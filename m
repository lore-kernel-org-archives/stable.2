Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594227;
	b=HwBldBkX801MM6Mtq0tekg2e2/6ebpPYO/6WoJylAlWjPUVIRQG3RLbiGjoBFOSjz48M
	 20P5aKIWfhDxttYX7sjPYSdcGKRF2fIatHHzTavOlY9ooQYzArYNpC+v5u6UyCIMfetNW
	 LA/3ZCPjmpTLzQ7VG5mJmcF38JUz/g90AYzFokBhC+2jP7OawsaT8keUHuuabCTy/C4Z+
	 GlYKlVrsQFLaDvsoqn8gKbi3LN58fGgelsBRLStSw2A6CR9dtmtz7wJMafPjZr0QAPnqv
	 G5Y3USCqJ6ZbwSpftFEyfIbk0ILL4jc3ww6G8HEytFLWBTygAfS5lVjl3MPqOv2AR8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594227;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KQnB4zdudDM+f22+PBg7XnMOl6dB4U75nhNmx7xw9IE=;
	b=Flbe24q8QM4lDSRA7+wH98zbErvv6F3kpi74UT+Lzw9JMJULogCaThABbJXAIR+3V76W
	 /tE3JltySuOKwmP2RjyoLJYGdNF3MJ24O2n9KlgXvuMbq50NOklHvjgrHMtv2HMsRup+Y
	 wHTxDJB466p5TiIHUcg9pQomLcGrN2e8hzP73keNSNNOMe2UfbUGeD+nnoQgWMGVSrQ4/
	 tdUlAuKvtFoOcTa18ZC0wo/IdWqaPvO/dzo6+fop3t7hKgdzqkVabR+VHsLjaJurSV3T+
	 8NMqb5L1ff+tqk/RONx8m/fPwGVg6EouekpRUrLT6CSsuDwMFPIAS+DfwT/vahmfQhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nDpRQ6Cy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85622606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=nDpRQ6Cy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A441F000C1;
	Wed, 21 Oct 2026 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594227;
	bh=KQnB4zdudDM+f22+PBg7XnMOl6dB4U75nhNmx7xw9IE=;
	h=Subject:To:Cc:From:Date;
	b=nDpRQ6CyJTiM4X+FaKcXgtVYVWx5N2ZjLYJGNHfkx4Ao7xccM9eWoFodvl+YSlhPn
	 gZStTHNhCsSzTbrAVWwPBGsuNMPYSn1VAqW4FuYEz5ZwNVFPs3vV28N9LtmslBOWMG
	 eGodwqrM8GiXuT83Maqgd3zYA7xdpDkCAO4U6TJ0=
Subject: FAILED: patch "[PATCH] lib/crypto: poly1305: Use memzero_explicit() in" failed to apply to 6.1-stable tree
To: ebiggers@kernel.org,ardb@kernel.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:40:50 +0200
Message-ID: <2026102150-peso-decent-0492@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x da619121a5d271e78ec709a1f9a3c5f99b9e10ad
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102150-peso-decent-0492@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From da619121a5d271e78ec709a1f9a3c5f99b9e10ad Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Tue, 6 Oct 2026 10:34:32 +0200
Subject: [PATCH] lib/crypto: poly1305: Use memzero_explicit() in
 poly1305_final()

Use memzero_explicit() instead of a plain struct assignment to guarantee
zeroization of the 'struct poly1305_desc_ctx'.

Note that dead store elimination was only theoretically possible with
link-time optimization here.  But it's still worth fixing.

Fixes: a1d93064094c ("crypto: poly1305 - expose init/update/final library interface")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-c3a6bd76-f6ab-4203-892a-cd06f7aa0c34
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://patch.msgid.link/20261006083432.16328-1-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>

diff --git a/lib/crypto/poly1305.c b/lib/crypto/poly1305.c
index f313ccc4b4dd..048c7afe8613 100644
--- a/lib/crypto/poly1305.c
+++ b/lib/crypto/poly1305.c
@@ -78,7 +78,7 @@ void poly1305_final(struct poly1305_desc_ctx *desc, u8 *dst)
 	}
 
 	poly1305_emit(&desc->state.h, dst, desc->s);
-	*desc = (struct poly1305_desc_ctx){};
+	memzero_explicit(desc, sizeof(*desc));
 }
 EXPORT_SYMBOL(poly1305_final);
 

