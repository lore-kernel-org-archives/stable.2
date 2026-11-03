Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=93.188.205.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710373;
	b=5qrraW6HG4ziiyux6gwGmV16z8Cbg24vdVSG7MLqYL0gQlZcP/GdQYfxztHO+AECv+AO
	 eqa1Kowev7z/EfpqB3ZoMqxeMRhPTK2VfhSlj7r3Xqf+V5HuLDKLmccA99g6dBBNewClY
	 dSzXpfP4GyulqlqXPz1oHaK4LtoaXXF7GXYZgBMcJlemj4TYTnouPBykIvjTQh3Lg8z8I
	 MxIQP3iJjsTK/d3WFA2u3zWcrhA37m1Trsx+4Vr2YUaH7dudnEoFP9F3zcQGUG2PEeunY
	 1ftZwO61+PZzdImfapes4ErV9+SQlEwjsAtEORNtEhwRdSGrWH8ite02RPNXaCJPCmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710373;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-LinksScanning:X-KSMG-Message-Action:X-KSMG-Rule-ID;
	bh=8hA8/g+bmMCq6bv5YDH3OeXIosbAXwn+RNBKjCSQfaM=;
	b=aFNm3mrVJqoigzL/0SDRyfahjcusUhAvNp/89ZNukW2v4Rczlzy2se95vYWCcotD4je3
	 IUv6/gkB0aCMEKPmGeiCh2sZo3oEHOt8g4L1e1FxT876PlMKxTxp6QSEbOAQsuXdxZ0A1
	 5nDoXhmjdj7kiXw+m9hqxQTwhndqkzBcy8zd+ooNwz+57Pb+V7crtAcielPCS4oWvvzwy
	 ssPxFGctl1wULrziTebQ33uAeEESPWWAkj1T3KCZJtk1+zkTd3bYfwgYYLzxAeamty1G0
	 9pUj4ODGEfQ+fRkIsA1HGprSy9Z3Qt/or6e0deoe/Nua7RnsD4btFVq0d4hZAtILIPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	dkim=pass header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=ykLiUdxW;
	arc=none smtp.remote-ip=93.188.205.243
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10922606A333;
	Tue,  3 Nov 2026 12:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10922606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=ykLiUdxW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1793710362;
	bh=iouGWSMMa76ghwbzwSYQ6bAw7O0sN2zqkEE0UIP46bw=;
	h=From:To:Cc:Subject:Date:From;
	b=ykLiUdxWD+FUHhMSFlnG326R1gDFgCSR6JuEP42ivk6fJK84+ldEl1Zf+5NMZOEkG
	 iBqxPCON5M61IjyIqsiyXMwBjIASRwZV5BvsUMXmVypdrv4GiNgZ5Ys8iOhxbnW34U
	 PJKfc7b3XrDncNLGqcZ+OaJeg+MJmPgLC/D23FN5arZjYL1btjFravq41pSXRCTY8j
	 GNtjQi+D+Ca4FQOfXxKf9cSi6MEGLOWxSXCyI4rl9H484QO5rJpBeDPwPxoO9IafDU
	 /YxGkHS99gupu/Ihi56tLZ3M7gue8ZI2Pdrs1bXtwQm31Tpam9BYC5aGuKHN7mkeSG
	 2nBr49abPVZ+g==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id B499E1FA27;
	Tue,  3 Nov 2026 15:52:42 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Tue,  3 Nov 2026 15:52:41 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.27.207])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4jJlCK5Myzz3vN0;
	Tue, 03 Nov 2026 13:28:13 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Yinjie Yao <yinjie.yao@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10/5.15] drm/amdgpu/vcn: set no_user_fence for VCN v2.0 enc/dec rings
Date: Tue,  3 Nov 2026 13:27:48 +0300
Message-ID: <20261103102754.1500-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 133 0.3.133 d508d579b02cdb6df47808421a9b9e12fc9fb75b, {diag_burst_silent}, {date_rfc_vio_soft_silent}, {Tracking_from_domain_doesnt_match_to}, astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207221 [Nov 03 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/11/03 11:26:00 #28786010
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Yinjie Yao <yinjie.yao@amd.com>

commit 8d80b293b41fcb5e9396db93e788b0f4ebcbafb7 upstream.

VCN encoder and decoder rings do not support 64-bit user fence writes,
reject CS submissions with user fences.

Fixes: 1b61de45dfaf ("drm/amdgpu: add initial VCN2.0 support (v2)")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit e2b5499fca55f1a32960a311bbb62e35891eaf73)
[mdmitrichenko: Adjust the ring initializers to the 5.10/5.15 context,
 preserving the existing vmhub fields.]
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-63856.

 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index e2744f172610a..da3809fef38ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -2005,6 +2005,7 @@ static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
 static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = vcn_v2_0_dec_ring_get_rptr,
 	.get_wptr = vcn_v2_0_dec_ring_get_wptr,
@@ -2036,6 +2037,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
 	.nop = VCN_ENC_CMD_NO_OP,
+	.no_user_fence = true,
 	.vmhub = AMDGPU_MMHUB_0,
 	.get_rptr = vcn_v2_0_enc_ring_get_rptr,
 	.get_wptr = vcn_v2_0_enc_ring_get_wptr,
-- 
2.43.0

