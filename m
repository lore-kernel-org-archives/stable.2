Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046628;
	b=q7UBKHBihencnYych2fwX2INGr4ATonwW8XjmBlkfIwcIN9TDb7LMIj9aRXUcGIYB4IF
	 +BqdQIQipFqVwWWShTL8WK0ZmpA+OFYvlYcYzwUot/zxY+0fR7ZYuvU6Pdli3y9RqYA9s
	 2q0X2JP1Ypn46TFDWJ2jKDLjaD8nC2DO6cdo7h76tBDyYPG9kgfc1X/9hX7inUjDlFVJA
	 25uswJXa4U3YGAlhacfF02m6B7GB3fACYHOcnz0Y4etfqGHVt2Nx5pbfrSYRlrlBKxDEz
	 PNn6vCNEHNGVKo4mHAHZg3SJsK9Ic01unSvZ04X6Twhe8A7Rm8cBv0Gr7eQpPalmJzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046628;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5MgasJ9SXh8ISG9xqfLpoZcW1NaARzsCXe3rTK7GBUA=;
	b=SgIcpRqR35boIXxOWsb6WKV0BfMkRip45nzQ6ZBClOVKpNi8BuhShzSnrBIH2UUGvTrc
	 apWuQdVL+H12i88/C3EuQTFHuvFmWBK27TjeJSN2cd42tkhop090qz3AVSIgsxCxoUqML
	 Fmq24nEAGJKM2J3Af6ZeDgYJfCs9Nd3YlXb0VfyOC2HsrJx28O/xJIilryLYrOGqrLoho
	 3PtIUvtbSKmbHdTMo84LSdBUBWEbtY1YnnLBlIYa0+eLM6XGDAXc2fcre2wLKd96TFA+n
	 Znksc4uC3xG05/ghkawd86nIJTQhPsBzW/oY8tTyAjLGQ+LjGXLa3U2tn/Er16TCcLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h5hG9UeD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025E960A381A
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h5hG9UeD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083871F0089F;
	Sat,  7 Nov 2026 10:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046627;
	bh=5MgasJ9SXh8ISG9xqfLpoZcW1NaARzsCXe3rTK7GBUA=;
	h=From:To:Cc:Subject:Date;
	b=h5hG9UeD2Ud+Zwvlr7WmHzS/7oUfipSu7Jq+4n4cghWozYMpCpT+gjgAlBi/gA6Jc
	 +2D/sOnBoDrzMZJKwrnnm2VCkjUaogqeKKoR9Z54xz0G5RJE2z12I1NJ2xWVkQ33S1
	 LRx3GAp22/dbsdsZopANg/ohwKGicYH1E34elXUYrw8/dPd7iut5hywk0X/2Ab0t0T
	 6a2cB///53V2A3Nz0yz+dmBIvd3BfwHm5a23S+IJgMfbkj3MJZtG6/8BDDSz2ZvSZP
	 U7kGWqeUm88Z8u0gRdTbdvF2qb3ioyzAEIRsCpNb52MfmvYEOz4NFdEGHkFljYN08S
	 gHcrJItfyR0Aw==
From: Sasha Levin <sashal@kernel.org>
To: tzimmermann@suse.de,
	jfalempe@redhat.com,
	javierm@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/panic: Do not use un-escaped URL as format string" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:17:05 -0500
Message-ID: <20261107051705-failed-6.12-6596aae25585@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6596aae25585b183ebd528206bde6f12efaf8db1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051705-failed-6.12-6596aae25585@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6596aae25585b183ebd528206bde6f12efaf8db1 Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri, 11 Sep 2026 14:43:54 +0200
Subject: [PATCH] drm/panic: Do not use un-escaped URL as format string

Replace the direct use of DRM_PANIC_SCREEN_QR_CODE_URL in snprintf()
with a %s conversion specifier. Avoids a possible vulnerabilty from
a crafted URL string.

As the attacker needs to control the kernel at the Kconfig level, the
potential for an exploit is likely low.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
Fixes: cb5164ac43d0 ("drm/panic: Add a QR code panic screen")
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.12+
Link: https://patch.msgid.link/20260911124540.279841-2-tzimmermann@suse.de
---
 drivers/gpu/drm/drm_panic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index e576c4791861d..ba21df4be3380 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -658,7 +658,8 @@ static int drm_panic_get_qr_code_url(u8 **qr_image)
 	char *kmsg;
 	int max_qr_data_size, url_len;
 
-	url_len = snprintf(url, sizeof(url), CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL "?a=%s&v=%s&z=",
+	url_len = snprintf(url, sizeof(url), "%s?a=%s&v=%s&z=",
+			   CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL,
 			   utsname()->machine, utsname()->release);
 
 	max_qr_data_size = drm_panic_qr_max_data_size(panic_qr_version, url_len);
-- 
2.53.0




