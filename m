Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794301405;
	b=qK0x/fbLxGC8JAe6Qym+jou7AU8Z+wNygRdl/p3xbiSJyFkn5DHr+TEsxgDOpQ2yW6Id
	 Mc2YzRZiS5NoZDdtdnOAIrMjt3J6e+8hZULg/OS+cQcpigvMHzetPv2iDf1eTN1SKQrD1
	 bPoikQhQYeUDA1KQyDwWlw7OwDASpH50MkY4ULYOIOly4ZdItPSgqzceesJBo7V+MXd9S
	 Vx7xP0YQ/5pmOYyiY98QOGkuePQK5AZRv0lTvloqSZu1BqlDXE8oxfpmnddabw7E4+mvm
	 YnSy2PDFxDmzGhLvrFPLq0ShZGqc5C+SwyRPpayVLNnCWaLfVKV1DLbdW20bPzyXzSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301405;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=JXp0LajyOpt+8qdQrYT7MGMlrs9liY208eOMm03msTs=;
	b=JruCMRrJJUPzf0DrlbGLfb0bVgkMGXjXU1mxm0/lwz4j/kG2e6Boxd8rmG6F4Mj4cx/O
	 K8Ha+7m97HBMz677xFT0WdMIoTagxIC4NhdWdmSVkY+BtyswM1Ejy2ESeI81zPN9aoT4q
	 DAtYer7KAr5nXYTe3dgK3T+Qnjcw3vJjbhxRHmBxIA5Yl19Ct+zNuGS4gwH4D8KlL45y6
	 bbOSJ9ts3kEYbAHQgX+wIOIrilAcpKQHZor+kxjH4jVkB+VSOJ1FXRQqGMJGusfIYVIzP
	 O50Mzdezb3Dtnf+arPpea6BGViHCElIJE5gmYWcoZ0Rs13F1mcnkzr+jIsiV3cziJ2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dwSAsEuu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCF460A2638;
	Tue, 10 Nov 2026 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dwSAsEuu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794301404;
	b=ReUHUz2+ZgZZBcmhMiei9j9myPpgG8uWU4htOYNA0Va/zMpYbzzzc1Pkp01MP09z4WdF
	 1gooIBNkwdGi8rwZswF2qwRWpPc9EjoEmNBFz97LMJ0n+ju/qqnb0QrcE7fO/Fvbix9p0
	 rSw/BqNOIed+S63W9zmaBN8rgLDLvQCevWMa+88vs1vGRmYMRgGaNwHTEdKOfhcWeJjnn
	 Th897tX83QZ8qSvpDJ2nN/ScWxs7KMJjkw6sgfxhN4xbmPCS9zpI5/ZIfr0XfJkOW7Za1
	 7MWf29QFnRDiDo1yGObTe1MeaGqjcApr/25tIvnFoa6AeVVDwtylP3Cg+XfoPfV5PBw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794301404;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=JXp0LajyOpt+8qdQrYT7MGMlrs9liY208eOMm03msTs=;
	b=YTRNiAvp/l/Y7bjxwthYwNv4xwUkO6T41dvoICsZn6ty/yKUzqRW+r7iwjmQHOx1iWE7
	 WoKOyWVLanlpGWQw8kX0LPkrknsswZwgazauLGRoqcHxonXCi0HHq3r7H4F0wFTqq3sFm
	 z49Mv3uMKvX3IP9wm9FcLpYaxYkwe4g+57UECMqGZT2rhNlv03ZXQKiMxU+jm8GCWj2EM
	 e0ky3XG/yo7HrqF4PVJdq7XjNKaYUXc+gSGwAvHuWUcPNAll7Xz9cAkqYg2vLr3VqHUf+
	 rGjKhhdg14jyA7m7IX45U7E/ULBPQliHy7ECxW9fLin9S3fwN0I51CGIV33v3CIy3gw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4CFEA1F0089F;
	Tue, 10 Nov 2026 09:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794301404;
	bh=JXp0LajyOpt+8qdQrYT7MGMlrs9liY208eOMm03msTs=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=dwSAsEuur+M/VgRjrpoec0HuqOdnQ2DOqwo329CeUq9LakXs+oJZ8WvN3ocH/rGqf
	 VY5uACIe2EGtMXKrNIwguntW3j6PPK0AZN/PTkZWP/Fh72AAr2PsR6JrYGZfH/EX+T
	 CESGqdS0xuevmSD6FML0pC0sKinDDoTz14oez7EHfyxUpoYXVXwGiD6bU9jjukoSIU
	 sORpTdpoTULbqz6cj5IHsWw1rsGev9mvyBpS67d4HAA4MjZiCPfAu6uyXNZ6L0rWtp
	 enSBaa5ICuQDdwZIEKqWuPjYKONqdgmLCPQehSqm/2b6mAAV5GnmRLr3tXC+OJxcbO
	 zCJ2nYpcQdPcw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D225D48A47;
	Tue, 10 Nov 2026 09:03:22 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 09:03:23 +0000
Subject: [PATCH wpan] mac802154: llsec: reject secured frames with security
 level 0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-llsec-seclevel-none-v1-1-06ef143e467f@gmail.com>
X-B4-Tracking: v=1; b=H4sIANrd8moC/x2MSwqEMBAFryK9tiEJOH6uIi5i5qkNoZUEVBDvP
 mEWtahF1UMZSZBpqB5KOCXLrkVsXVHYvK5g+RYnZ9zHWms4xozAhYgTkXVXcB+6pXFm9q1pqZR
 HwiL3/zrSdXil6X1/TSPEBmsAAAA=
To: alex.aring@gmail.com, stefan@datenfreihafen.org, 
 miquel.raynal@bootlin.com, joasantonio108@gmail.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
 pabeni@redhat.com, horms@kernel.org, linux-wpan@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794301402; l=2972;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=D5EaJBjC8M7RHA6vb/0t+xHzBpEctd0lgATfGQnGuqA=;
 b=AvenG5SdRGme9uWM1JQXBb23fS5x4xf0jrQTz85B6HBZqxGbSsPXPzg0f/YdjhL4nm/a7ahLI
 L0RJfiznDZlCixkBjbh0cLzFuYGNmpUKOiVuM9ZIZpIYKtlREw0yxhs
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

mac802154_llsec_decrypt() handles every received frame that has the
Security Enabled bit set.  The security level is taken from the
auxiliary security header of the frame and is not required to be
non-zero.  The only check that looks at level 0 rejects the frame only
if level 0 is not allowed by the matching seclevel entry, the entry has
device_override set and the device is not seclevel_exempt:

	if (!(seclevel.sec_levels & BIT(hdr.sec.level)) &&
	    (hdr.sec.level == 0 && seclevel.device_override &&
	     !dev->dev.seclevel_exempt)) {

Otherwise the frame reaches llsec_do_decrypt(), which sends every level
other than IEEE802154_SCF_SECLEVEL_ENC to llsec_do_decrypt_auth().
There ieee802154_sechdr_authtag_len() returns 0 for level 0 and

	req = aead_request_alloc(llsec_tfm_by_len(key, authlen), GFP_ATOMIC);

looks for a transform with an authentication tag size of 0.  The key
only has transforms for tag sizes 4, 8 and 16, so llsec_tfm_by_len()
runs into its BUG().

The frame is not authenticated at that point.  A station in radio range
can crash a node that has llsec enabled if it sends a frame that matches
a configured key entry and a device table entry (source address, key id
mode and key id are sent in the clear and can be observed), uses a frame
type that has a seclevel entry and carries a frame counter that is not
lower than the stored one.  No key material is needed.  The frame
counter of that device is also updated before the BUG() is reached.

A frame with the Security Enabled bit set and security level 0 carries
no protection and cannot be processed by the incoming security
procedure.  Reject it before any key or device state is looked up.  The
transmit side already leaves such frames alone in
mac802154_llsec_encrypt().

Found by LLM-assisted source review.

Fixes: 4c14a2fb5d14 ("mac802154: add llsec decryption method")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
This issue was found with the help of an LLM-based code review tool
(Claude).  I checked the code paths by hand against v7.4-rc3 and
reviewed the fix myself.  It is build-tested only (W=1, arm64); I do
not have the hardware to test it at runtime.
---
 net/mac802154/llsec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
index 85452ef9a58c..32565f18897e 100644
--- a/net/mac802154/llsec.c
+++ b/net/mac802154/llsec.c
@@ -1019,6 +1019,8 @@ int mac802154_llsec_decrypt(struct mac802154_llsec *sec, struct sk_buff *skb)
 		return 0;
 	if (hdr.fc.version == 0)
 		return -EINVAL;
+	if (hdr.sec.level == IEEE802154_SCF_SECLEVEL_NONE)
+		return -EINVAL;
 
 	read_lock_bh(&sec->lock);
 	if (!sec->params.enabled) {

---
base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
change-id: 20261110-llsec-seclevel-none-9c8f520ba707

Best regards,
-- 
Joas Antonio dos Santos <joasantonio108@gmail.com>


