Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441A93C13E7
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624563; cv=none; b=ozeTr8Yk2T5ZQ2LiwYfUQJ6iPtoZPFWSQA9IYqmHgMFtTvAq6pcJ5tb2F+DkY/8DTPZzyNPelXMNZEON9rxO5BYaz6JzUJrBH2hBV1Vww3afwOu3NVdg9XKKwcqco1e0gcku5gy6h5WKvnjgwysLxaVVv2j9zoMXoZ7WdG9x99I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624563; c=relaxed/simple;
	bh=peEo+qk5fGkai7l5BYOj2Cf0Jzcno40TbPQQAtaVcMs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IF7sXMc78C0YPzEaCjRJ4tL4wyJhIlt4QJEiULJVI+o/D9rv4rcnZWrDHIWuMQ5JKfTDB8KPDcDRTV42U5i8DDRMyDRPjTQYsMnxshOKvjuPLUPfj6jgwrKXLLU38Los4ni2AO4UPGK+PT/vhZBNbmC8sLHrJhAsN6c+BSCq3wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Axu7zxc6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Axu7zxc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10951F000E9;
	Tue, 21 Jul 2026 09:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784624562;
	bh=rrsVouBdRfIY14Mc3Ej2AX3ddeRTbvRMCPDXC3kOmBI=;
	h=Subject:To:Cc:From:Date;
	b=Axu7zxc6kcFCJ93Fap5VAhlpxnHHBLtngkcWOPZeKKe8KC2tMe7Wv/8ehodGOdrO5
	 RI4cYkoJm8/vQ7EWyKmtWoThYKhFeUzTfXhhiCJ1DmveY3+/09GbFONTtJuSICVpx4
	 KJPKf135+JYZjTyM/Si9egbtY9oetOEl8hBcmvGo=
Subject: FAILED: patch "[PATCH] net: ipa: fix SMEM state handle leaks in SMP2P init" failed to apply to 6.18-stable tree
To: haoxiang_li2024@163.com,elder@riscstar.com,kuba@kernel.org,larysa.zaremba@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:02:32 +0200
Message-ID: <2026072132-chatroom-aware-b80e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 96ca1e658ae459276292bd6d971ab5d8c7e0379a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072132-chatroom-aware-b80e@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 96ca1e658ae459276292bd6d971ab5d8c7e0379a Mon Sep 17 00:00:00 2001
From: Haoxiang Li <haoxiang_li2024@163.com>
Date: Wed, 24 Jun 2026 14:59:55 +0800
Subject: [PATCH] net: ipa: fix SMEM state handle leaks in SMP2P init

ipa_smp2p_init() acquires two Qualcomm SMEM state handles with
qcom_smem_state_get(). However, neither the init error paths
nor ipa_smp2p_exit() release them.

Release both handles with qcom_smem_state_put() in the init
error paths and in ipa_smp2p_exit().

Fixes: 530f9216a953 ("soc: qcom: ipa: AP/modem communications")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Alex Elder <elder@riscstar.com>
Link: https://patch.msgid.link/20260624065955.2822765-1-haoxiang_li2024@163.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
index 2f0ccdd937cc..331c00ad02c0 100644
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@ -232,19 +232,27 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
 					  &valid_bit);
 	if (IS_ERR(valid_state))
 		return PTR_ERR(valid_state);
-	if (valid_bit >= 32)		/* BITS_PER_U32 */
-		return -EINVAL;
+	if (valid_bit >= 32) {		/* BITS_PER_U32 */
+		ret = -EINVAL;
+		goto err_valid_state_put;
+	}
 
 	enabled_state = qcom_smem_state_get(dev, "ipa-clock-enabled",
 					    &enabled_bit);
-	if (IS_ERR(enabled_state))
-		return PTR_ERR(enabled_state);
-	if (enabled_bit >= 32)		/* BITS_PER_U32 */
-		return -EINVAL;
+	if (IS_ERR(enabled_state)) {
+		ret = PTR_ERR(enabled_state);
+		goto err_valid_state_put;
+	}
+	if (enabled_bit >= 32) {		/* BITS_PER_U32 */
+		ret = -EINVAL;
+		goto err_enabled_state_put;
+	}
 
 	smp2p = kzalloc_obj(*smp2p);
-	if (!smp2p)
-		return -ENOMEM;
+	if (!smp2p) {
+		ret = -ENOMEM;
+		goto err_enabled_state_put;
+	}
 
 	smp2p->ipa = ipa;
 
@@ -289,6 +297,10 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
 	ipa->smp2p = NULL;
 	mutex_destroy(&smp2p->mutex);
 	kfree(smp2p);
+err_enabled_state_put:
+	qcom_smem_state_put(enabled_state);
+err_valid_state_put:
+	qcom_smem_state_put(valid_state);
 
 	return ret;
 }
@@ -305,6 +317,8 @@ void ipa_smp2p_exit(struct ipa *ipa)
 	ipa_smp2p_power_release(ipa);
 	ipa->smp2p = NULL;
 	mutex_destroy(&smp2p->mutex);
+	qcom_smem_state_put(smp2p->enabled_state);
+	qcom_smem_state_put(smp2p->valid_state);
 	kfree(smp2p);
 }
 

