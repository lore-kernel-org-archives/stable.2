Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202749;
	b=TRS17X14s6B/+FOD/BbzXgUHiIgAI4H4FGzzdG4AG8dBkyhqNCO2EizX9pGbE/ySX1l0
	 Tltu4Rxf9MvWBj73H8SdH0ZB5IL/1bwLsIrPYbRQR5+u+wJ0w8IrPpOU7JrAa3VCXtMus
	 COMAWrXVGhUZLI+UsrQaqL5m/YzxxReTK2f0xW9AG9DbnoMxmzZhaS9unqIBpecaaqbNX
	 kOVEAsxSoxNn+r82R/V2aYkQ1QsmX8eT4UA0PhZ3HimvShCdmrP4ZiDJDgs6Zv1mRcc4L
	 r0fAhtFxiEjbgrEfimynr0+54T9M/cKsSN6v8lyR2SScpjILpV81kb5sZ390FY7lVUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202749;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4cYTJdb6hleL5/mTkMDM0w7nLSU3+ju8zZwuzUl+VRo=;
	b=LYdShiyij54G68Vk9zrJYqwq+DVO8rrdW4CI5+7d7/nLHF836Ehu9d8ndIVdVq1tGSdu
	 Rfwv+9r6A7v2HApWL8UJa784OcB6ubIjYjgUTE9QUiIyvvpe5qlflRabKAj2OETxQlSeQ
	 impdT4kUhxitubjKXszpJi/S0bSlcneQYqYpckavrl58k5P5EoV1nch8s5CRw73pauCl8
	 AM1lATV/unPVCawvYHqufqmRnNcTuyXkTVYEAou8HziZ8fXER/o3ipwQOaAuPmoHeEieZ
	 gGQWDOfwPJxN3RDbJ7rFdXRpsWoQ4K6EPL/EQK1bvxSzqzHaDDFX0dmCeEJ5soMBssw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=rPraOwQv;
	arc=none smtp.remote-ip=203.205.221.240
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD35A606A6C6;
	Fri, 20 Nov 2026 19:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD35A606A6C6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=rPraOwQv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1795202739;
	bh=4cYTJdb6hleL5/mTkMDM0w7nLSU3+ju8zZwuzUl+VRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rPraOwQvS7VWHWP/SErdAuCXiusAtwY00OIWdics7g2vuCSN3K4O0aQ/AgcuyOxeA
	 Xecnbip/HhCEmXwpN71aZlFa0Msro1/BXuo9DVo+RLbxsvzymw6dpldROVpvkpHNz/
	 jMncZvPtnoDb0EEmgGClZj/4dRLEikmX8vfoowcM=
Received: from localhost.localdomain ([240e:3bb:3013:2171:4526:e32a:3de3:2a2d])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 6642AA26; Sat, 21 Nov 2026 03:25:36 +0800
X-QQ-mid: xmsmtpt1795202737t5po9gzz8
Message-ID: <tencent_D1222948818CA62395FED66DB7F2967B1809@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUA7lFidggaKVIZH3eJxRJsUcjO135XHVnW5FNkny12Gr81VdNDsP
	 BGdTjNDuYoCDPG70Qf0a+9xkWcjDSp1oTtt27pAGshlvzPYFBqDsrAgB2Gfr+izybOnVJvg8dh5k
	 QwZgdVzVuEop0XCq7voYj7kAWLWs34h8Szg5H+l+3g9e71nL4cr3OFZ8QQ2s8hrK0FkJzCwKCRc/
	 boYfRI6MmsfqHwckNlHDy6xXQvGdVsHtlltVT5DV2j/GSkgMCWt7xl4Kk10fv+GBXElu/DhCbHNw
	 cM9FXzH0IKYNMfftWHakk+aiJyqzI3JUyQDVPXSx40/mHgx70s/Vz1py6oZvmZfylmfvAW0HDyPN
	 Oye+G2yCgozFnYZW1Vr6+oKwuA39OsNryti1pnkmT3I3sO0xZfaVaz/k5HiJ1eYKDW3BvZvQdBJP
	 aZ8E90XXvDOKcY4H93Xw6U89VKg/53TJvPXkYNrPWAZcXTFSDmZzhvwGAtIi0rSVb957RLV7Jhvf
	 xCj1yLZ1OIAdCRP2lsXIfgupkNI9faWRm/KF8DyeN4OA+EL+oEtGZMNKJBlgckUFdxlzPk55fcYK
	 iYslxNrXegfAEGkOnkLzZObjq6wss/fYV856JMGI0dTO6K1Xq0ESDb7dN4FDu1J1E0k8/2uj0Dkn
	 ixQdUJ6TZAKr71iBcGJQ9fHE8A9eGp/IclDxNzLDxBiG6HlIzYO0LplWPiONzrQ5tnr5MCSQk9ns
	 17yzd4JjzelS7PETkiRBsxji4xuMU5m0PxkjzU0pXvTDwXu+rclCuB8lwyeU9qlZ7ZTbm73eTiMI
	 ZYSRt7QFLKQW/2c/9rSjd4Dkv5vWQWsVpVGttV7d8RYXKog69h4fLKnKGt+Ap8nzDmxAEz7P58K0
	 mLjz/bRIpgP7HfTdhB0oretsgvynW/DnKPGSXOHt3lXXg85Ft1kOyyg07LS7n8XV3DJAjabl8Nf1
	 ZaOl74J4QW/bpkmeHaekGAViEVgP2Q9pXPfm+Os8tGfPtZpg7XWWNB2sGWrCR6kMVjfVT2sL8lNF
	 935rnDNiJA79VeZKHVwn1owPdQJpbywTzriA5i/K9571Yv76k5TA9DkO6psubw9mUcKVU97A==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: memoriaru@foxmail.com
To: heikki.krogerus@linux.intel.com
Cc: linux-usb@vger.kernel.org,
	badhri@google.com,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH usb v4] usb: typec: tcpm: exempt Soft Reset from the SOP' MessageID duplicate check
Date: Sat, 21 Nov 2026 03:25:35 +0800
X-OQ-MSGID: <1795204201.patch.tcpm-v4@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <1795204200.cover.tcpm-v4@foxmail.com>
References: <tencent_443620EAE95525A375BB2D8A653406630A07@qq.com> <awBIRnc9lBkdVhEK@black.igk.intel.com> <1795204200.cover.tcpm-v4@foxmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

From: Zhang Hewei <memoriaru@foxmail.com>

The PD message duplicate-check and the SOFT_RESET state handling treat
the SOP and SOP' channels differently:

tcpm_pd_rx_handler() exempts PD_CTRL_SOFT_RESET from the MessageID
duplicate check on the SOP path (USB PD spec 6.6.1.2 note: a Soft_Reset
message always carries MessageID zero, so the duplicate check must not
drop it), but the SOP' branch of the same switch has no such exemption.
A cable that sends a second Soft Reset over SOP' (MessageID zero again)
has that message silently dropped by the rx_msgid_prime comparison, and
the cable-side re-negotiation stalls.

Exempt Soft Reset on the SOP' path the same way the SOP path does.

Found by code inspection; a software TCPC stub was built for the
responder path.

Fixes: 6bd181ba60e1 ("usb: typec: tcpm: add control message support to sop'")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Hewei <memoriaru@foxmail.com>

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index bb90211..89e280b 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4200,7 +4200,8 @@ static void tcpm_pd_rx_handler(struct kthread_work *work)
 		 */
 		switch (rx_sop_type) {
 		case TCPC_TX_SOP_PRIME:
-			if (msgid == port->rx_msgid_prime)
+			if (msgid == port->rx_msgid_prime &&
+			    type != PD_CTRL_SOFT_RESET)
 				goto done;
 			port->rx_msgid_prime = msgid;
 			break;
-- 
2.39.5 (Apple Git-154)

