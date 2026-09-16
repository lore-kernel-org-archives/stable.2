Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6161F51FCBB
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572461; cv=none; b=RElErIvu6cebb5yIzkcc+FWVhzF2dtbJywg4NoODp++nqhAL0LL5nmLGPiFJqAuWlTM1m4p3QLUFDgWK/tKqeEngKXjj1gyA+sfbYGRLRlYgTA/dCMwYUCOJpaQVHDWCiNUzHej40bN0yFjaPvKqIa2jEgTywypnu3N0hVXQ+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572461; c=relaxed/simple;
	bh=KAATmG01pKJthu069cEjZVLAA/XWnH8ADFQ47hHgG5w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=di4jIwQZvUugUTyjcJ9nNWa3XmDhEmcrSbJ9M2C/WKL2D/kuxI+TubfHpytKTLChXFf9X/v9Uo6PzSAU7/dmaUxqs2zrAZKp/ne1/2xlmOd14deM/HgTVOpBszSzjI30mg5IQYvrCQl/8mgGjEwneemiT/OOsYekN583uwNtJ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q2j4Y06n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q2j4Y06n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8D31F000FF;
	Wed, 16 Sep 2026 15:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789572456;
	bh=VCImsAnjTtWI+5VhbAysqZsvBv9D0ojs2la5DF0fP2w=;
	h=Subject:To:Cc:From:Date;
	b=q2j4Y06nwrtNwiTuxvCuVCAqaqEYNhXUaWFg6kFmvdgEXexmNuTGZVKJhJrFSUAh2
	 +ZfOSwMoLMb7HId2Cz3WX2SG9LEf8D7DoKOjF9eNZY0cive/YV9v6ROzx++aGzh8ez
	 +b+zkBfxl8X63DRj4pmiHU5Ex9md5GEzIv0XZeac=
Subject: FAILED: patch "[PATCH] Bluetooth: btqcomsmd: destroy RPMsg endpoints before freeing" failed to apply to 6.6-stable tree
To: raoxu@uniontech.com,bartosz.golaszewski@oss.qualcomm.com,dmitry.baryshkov@oss.qualcomm.com,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:14:51 +0100
Message-ID: <2026091650-java-skiing-cc15@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f5a427b16e45210dee656b0860728f3d496dee85
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091650-java-skiing-cc15@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f5a427b16e45210dee656b0860728f3d496dee85 Mon Sep 17 00:00:00 2001
From: Xu Rao <raoxu@uniontech.com>
Date: Fri, 4 Sep 2026 10:54:57 +0800
Subject: [PATCH] Bluetooth: btqcomsmd: destroy RPMsg endpoints before freeing
 hci_dev

The command and ACL RPMsg endpoints store struct btqcomsmd as their
callback private data. The receive callbacks dereference btq->hdev
without taking an hci_dev reference.

The current teardown order frees the hci_dev before destroying the RPMsg
endpoints in both the hci_register_dev() error path and the driver remove
path. If WCNSS delivers data in that window, the endpoint callback can
run with an already freed hci_dev and pass it to the Bluetooth core.

For qcom_smd endpoints, rpmsg_destroy_ept() closes the channel and clears
the callback under the channel recv_lock. The receive path holds the same
lock while invoking the callback, so destroying the endpoints first both
prevents new callbacks and serializes with any callback already running.

Destroy the command and ACL endpoints before hci_free_dev(). Keep
hci_unregister_dev() first during remove so the HCI core stops issuing
operations before the transport endpoints are shut down. In the full
registration-error cleanup path, return directly after freeing the hci_dev
to avoid falling through to the partial-construction labels and destroying
the endpoints twice.

Fixes: 5052de8deff5 ("soc: qcom: smd: Transition client drivers from smd to rpmsg")
Fixes: 9a39a927be01 ("Bluetooth: btqcomsmd: Fix a resource leak in error handling paths in the probe function")
Cc: stable@vger.kernel.org
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index d2e13fcb6bab..d669ea4eb3eb 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -188,7 +188,10 @@ static int btqcomsmd_probe(struct platform_device *pdev)
 	return 0;
 
 hci_free_dev:
+	rpmsg_destroy_ept(btq->cmd_channel);
+	rpmsg_destroy_ept(btq->acl_channel);
 	hci_free_dev(hdev);
+	return ret;
 destroy_cmd_channel:
 	rpmsg_destroy_ept(btq->cmd_channel);
 destroy_acl_channel:
@@ -202,10 +205,11 @@ static void btqcomsmd_remove(struct platform_device *pdev)
 	struct btqcomsmd *btq = platform_get_drvdata(pdev);
 
 	hci_unregister_dev(btq->hdev);
-	hci_free_dev(btq->hdev);
 
 	rpmsg_destroy_ept(btq->cmd_channel);
 	rpmsg_destroy_ept(btq->acl_channel);
+
+	hci_free_dev(btq->hdev);
 }
 
 static const struct of_device_id btqcomsmd_of_match[] = {

