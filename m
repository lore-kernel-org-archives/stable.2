Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685632;
	b=r2+XJTLp+i5JGh+E7zu/SRlnSGI2SPJc2R8Eond5wQUdHatHYDDE3qjuVO4eLkkr5cqX
	 PDQ0XH7mFsfI/diancGBNlVkehBzJVlye9RkaK5AfQ2W2P7X9wNu22L6VDuPogIArNLBL
	 k2GTLd5f3XDrzoq0BxSlSZfX2t5N1Q6/UhwosGtbv6ej7XkT13TjnJe/o25JGOcsHQiM0
	 z0BteqTDqCuUlssd6NaGWu05wnq2nLG4W/y4qNb5YOnLcps7vVW0QrAyiIIg75VR4yv9C
	 rK1BdmiL1MdyEWYv++4LrOrAmmI7V2Ll1GNrSRbEDECeYlMrfheAYYugqDzhnp4qssw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685632;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7QcJ6tBuLoqHPswlbVhYm5kRSsDto3rtTMzCHGSw+do=;
	b=lZdliJCrRiRBfUW7hOu1RJWFbPXraVuv7nTUSBPh4sjzkezkXi17deECErLJZxOIPYLZ
	 FoLf58MQ0cezAnSfbV8lEXAXboTyBKAJcE3a0rMsAellXprFI6HUEzk/vRrkvs6UJdHU9
	 fS16Zt6HrTku37td0a64nC8zs0DPE3Yh24KHGoVpRjVa0zZ6UBc2Dv9PgRY6gbobuJoLH
	 zgXb0J5fb/M1h/ZbGZIHjqn3B9f8gX44JpmqaCHIQlYAHuKSBt49TX7NIvEeNt0NAK46N
	 jXlsPhg90YXGmyj+JjQTsuLESiLhm8fmB5hoPEy0boKew6ny5tTyVa7CzJygkjyNxNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=XhG4orjH;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0A5606A31E;
	Thu, 26 Nov 2026 09:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C0A5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=XhG4orjH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=XhG4orjHsMt5yBOugUXML3k553m4+/j6ZLIsYxfO8yhktU1pFnD2qhw8XWxjEmzyNPec/krvyZWWP
	 Xn7hib3NROSUT8RE6+W3RIiR6gqdWdG0+PxfN8eRVyJb9TU4XgaX6ghWyvIn0eHbDzc9mOGgBTNKjV
	 katKky6gOXnnfSkg=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46b07fcf91a7-fba8f;
	Thu, 26 Nov 2026 17:33:47 +0800 (CST)
X-RM-TRANSID:2ee46b07fcf91a7-fba8f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.112.32.189])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16b07fcf9819-670bc;
	Thu, 26 Nov 2026 17:33:47 +0800 (CST)
X-RM-TRANSID:2ee16b07fcf9819-670bc
From: Hongyu Guo <guohongyu@cmss.chinamobile.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	alan.brady@intel.com,
	stable@vger.kernel.org,
	13057616121@163.com
Subject: [PATCH v2] idpf: fix vport_id used as array index in MAC filter async handler
Date: Thu, 26 Nov 2026 17:26:27 +0800
Message-ID: <20261126092627.255454-1-guohongyu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126020854.233971-1-guohongyu@cmss.chinamobile.com>
References: <20261126020854.233971-1-guohongyu@cmss.chinamobile.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

idpf_mac_filter_async_handler() looks up the vport with
idpf_vid_to_vport(), but then indexes adapter->vport_config[] with
the raw vport_id from the message instead of using the vport it
just found.  vport_id is a device-assigned 32-bit number and is
not limited to num_max_vports, so vport_config[vport_id] can read
past the end of the array.  Use vport->idx, the array index the
rest of the driver uses.

During driver removal the vports are freed before the mailbox
work is cancelled, so this handler can still run while a vport it
looks up is being freed.  Return early if IDPF_REMOVE_IN_PROG is
set.

The filter removal loop in the same handler also leaks: it does
list_del() without kfree(), and if the response lists the same MAC
more than once it deletes the same entry twice.  Free the filter
and break out of the inner loop once it is removed.

Fixes: 41252855df77 ("idpf: add async_handler for MAC filter messages")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyu Guo <guohongyu@cmss.chinamobile.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 1caf52706973..ff43a3d34eac 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3779,6 +3779,10 @@ static void idpf_mac_filter_async_handler(void *ctx,
 	if (!status || status == -ETIMEDOUT)
 		return;
 
+	/* vports are freed during removal, before this work is cancelled */
+	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
+		return;
+
 	ma_list = buff->iov_base;
 	/* make sure at least struct is there */
 	if (buff->iov_len < sizeof(*ma_list))
@@ -3794,7 +3798,7 @@ static void idpf_mac_filter_async_handler(void *ctx,
 	if (!vport)
 		goto invalid_payload;
 
-	vport_config = adapter->vport_config[le32_to_cpu(ma_list->vport_id)];
+	vport_config = adapter->vport_config[vport->idx];
 	ma_list_head = &vport_config->user_config.mac_filter_list;
 
 	/* We can't do much to reconcile bad filters at this point, however we
@@ -3804,8 +3808,11 @@ static void idpf_mac_filter_async_handler(void *ctx,
 	spin_lock_bh(&vport_config->mac_filter_list_lock);
 	list_for_each_entry_safe(f, tmp, ma_list_head, list)
 		for (i = 0; i < num_entries; i++)
-			if (ether_addr_equal(mac_addr[i].addr, f->macaddr))
+			if (ether_addr_equal(mac_addr[i].addr, f->macaddr)) {
 				list_del(&f->list);
+				kfree(f);
+				break;
+			}
 	spin_unlock_bh(&vport_config->mac_filter_list_lock);
 	dev_err_ratelimited(&adapter->pdev->dev, "Received error %d on sending MAC filter request\n",
 			    status);
-- 
2.43.0



