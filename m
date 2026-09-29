Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0800A5172FC
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683035; cv=none; b=RCVU9upfmgCNCsDPx9ba1y2PbFZK16nLwgIngGTOsFTdt17PItPw5RfUIdXxN6qh2oZA6do7k3jAMD02JMPgk4Mtz8IRkxB96kr9If5zFKl5/Pw1HVjikwWHrdkEVetTwsbJ/Uj6Ird9mIV7xnMhYdAlPIfsWGDlofQikq0mKH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683035; c=relaxed/simple;
	bh=msX91dBb4enm21u9FyNWoBenlnDH0AuuCq8sW12TGLs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bIpTxZiSNsi4OxShcmYYVxw3MZEJxSStdfZYLbFvWwyZdTtiwGNx2ioMwXRCOnnJ9pvkTlF69BLVKoRcTMTmszy5gI7ij9BFRTAHlhMg3u8ezIpJRPINtFtMqSEDXfFUqg88KwKIeg1qAJvOH2x4dO9nLb+HiEIylN98eXmvSHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MWtLu4H2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MWtLu4H2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6154A1F000FF;
	Tue, 29 Sep 2026 11:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790683033;
	bh=k1bUYdMKl+HfdbeAx/cjd3VYFpd6PQl9/nsCV8aBgKk=;
	h=Subject:To:Cc:From:Date;
	b=MWtLu4H26KhUCehAxDQC8qmvO4LpYizTHZn28nyIfSxdsYgHYMha+AUw/BlCrbGp9
	 k/juhhR2EIqoMmwAib3UEnvBGkxxdXiKupiwavxyN5XDzMjd30NHkEERXAc7D0XwI+
	 SvdWvZmnNFecTj+QATeZqAp5LZHLBsfQE9Uk/cvQ=
Subject: FAILED: patch "[PATCH] Bluetooth: mgmt: fix race in read_unconf_index_list()" failed to apply to 6.1-stable tree
To: qwe.aldo@gmail.com,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:55:18 +0200
Message-ID: <2026092918-appraisal-strive-14ac@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b5dbb41b212c50c095a4dbee3017a84fe94f033b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092918-appraisal-strive-14ac@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b5dbb41b212c50c095a4dbee3017a84fe94f033b Mon Sep 17 00:00:00 2001
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Date: Tue, 15 Sep 2026 12:59:52 -0300
Subject: [PATCH] Bluetooth: mgmt: fix race in read_unconf_index_list()

read_unconf_index_list() counts unconfigured controllers before allocating
its response, then checks the device flags again while filling it.

hci_dev_list_lock stabilizes list membership, but it does not serialize the
per-device flags. During asynchronous controller setup, the worker can set
HCI_UNCONFIGURED and clear HCI_SETUP between the two passes. A controller
omitted from the allocation count can then become eligible for the fill
pass, causing an out-of-bounds write to rp->index[].

Allocate space for every device on hci_dev_list. Since list membership
cannot change while hci_dev_list_lock is held, the response remains large
enough regardless of flag transitions. The reported count and response
length still include only eligible unconfigured controllers.

Fixes: 73d1df2a7a10 ("Bluetooth: Add support for Read Unconfigured Index List command")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f740e745ae78..41956cdde982 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -496,13 +496,9 @@ static int read_unconf_index_list(struct sock *sk, struct hci_dev *hdev,
 
 	read_lock(&hci_dev_list_lock);
 
-	count = 0;
-	list_for_each_entry(d, &hci_dev_list, list) {
-		if (hci_dev_test_flag(d, HCI_UNCONFIGURED))
-			count++;
-	}
+	count = list_count_nodes(&hci_dev_list);
 
-	rp_len = sizeof(*rp) + (2 * count);
+	rp_len = sizeof(*rp) + (sizeof(__le16) * count);
 	rp = kmalloc(rp_len, GFP_ATOMIC);
 	if (!rp) {
 		read_unlock(&hci_dev_list_lock);

