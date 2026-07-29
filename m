Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC180361640;
	Wed, 29 Jul 2026 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785347227; cv=none; b=fYiYQjU9a8ra5CS2vLCb5k1mVSAXmEDqgjbA9CsLCad+VpIvf+Fm7VfDyDy6PtMo8Q8rN7ESJWxm9j14VUDrBdf2haOUjK2Z/EL2Xrm7Vog700sRAnT0tkzzCRdfVqYmHUj/Tv/Xf4N9ochvnBW7hYeU5BNFl/lH/e4wOGaAWSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785347227; c=relaxed/simple;
	bh=42+F2Xrgfj2xm45hy7pkfY2+jrMgOGuLvgG3md5+MQI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XSZ9PSu8Z7Co7b9VRUB4z5/yf2nquV8UIj6Yww/oDvka5LwySasAmL4mE2mCiR3Hbz0Dr4X3YIm8QEo/3HSIzVlPWyHaAmkcJ/U0VSH0vaGNHRaoUKOaaUfm6B+jccNFE26NMIb/xLZPkGNzPECDAO1YIExDtaZzo9P4GQGHOD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=o3q8oViT; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="o3q8oViT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785347191; x=1785951991; i=spasswolf@web.de;
	bh=ZFPNp+Fg+2pjDSRFJqjeCZvO2vawuNhy8ixNHTeie1Q=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=o3q8oViTpfc376MBHSyYlbaEXO7kLVpmK5zXOSIsY29u+PZ1EJ07ePigmLPFjftS
	 80YpePOue8U9pznMbvi25XoE2HB09j9L4ioAGGXGqlPoiqMV6TWSvlkBEsfyhay6l
	 Jf/NHokAnl6cRJXfAX5JXMb3RjhrLJPLY/4vAIROkCIve5la7nZ2eZxxxFSPQeRZV
	 yJ/uUz3/eULlgl2rp26XYx0R9h1LZuABWq1A5+V4D2Ag+Q3xGKtiVeGibSeNq5Nd2
	 NFjUMl7VJJu1e8BEBFaULJzFca57ie+gzw43lVBTMRTFgZyDTdZpjTNGPSEAdvxPv
	 zaxUnRDj3aTwDOLrIw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MrOhx-1xKqGW2oGV-00b5r6; Wed, 29
 Jul 2026 19:46:31 +0200
Message-ID: <df5f0d9bb8f11d098f086bd2ace5aa0cef4c77d7.camel@web.de>
Subject: Re: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with
 PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, amd-gfx@lists.freedesktop.org, "# = v7 . 1"
	 <stable@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Rafal
 Ostrowski <rafal.ostrowski@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 spasswwolf@web.de
Date: Wed, 29 Jul 2026 19:46:30 +0200
In-Reply-To: <CABXGCsONHe2ST-==Gso2748i7W_POPiUAF2MrrmTuqoQr7z3gg@mail.gmail.com>
References: <20260727105059.75716-1-spasswolf@web.de>
	 <ef1bc3d070c4156f1811c0c4a567ec98ac8fadaf.camel@gmail.com>
	 <1ead313022bc62dce1f42af9f855727eb9074443.camel@web.de>
	 <CABXGCsONHe2ST-==Gso2748i7W_POPiUAF2MrrmTuqoQr7z3gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UXXL9xVFpg84xFCHB0rG+aFtlnKYFsvNaO2LJ6ztbTlTWScBW32
 BgWfph7RlZ4Yya/SvHevYKa2i0CsFR2DLiiZNo+A+Ekc0BO0jAoNUxp4jMsIaEnmdmXRYxx
 8ItAG/POu3u2BZPBEq0aUsbxKAWboDPu/iM7UrcXx+m8Z66/wPHOA0cq/IAGQw+h/TmUNdG
 hpETCRAT/v/dPDMgoYlwg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+sRb66bWAp8=;RXpZ77x9BO0JodeOZynvb+IqnKE
 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
 sdy/5XB2RTXG

Am Dienstag, dem 28.07.2026 um 05:51 +0500 schrieb mikhail.v.gavrilov@gmai=
l.com:
> One thing that may be worth adjusting in the commit message: this is
> not only a PREEMPT_RT problem.  183182235f6d was needed on a plain non-
> RT x86 kernel. There DC_FP_START() takes fpregs_lock(), which disables
> local softirqs, and dc_plane_state is around 335 KiB, so kvzalloc_obj()
> falls through to the vmalloc path and hits BUG_ON(in_interrupt()).  So
> on RT any allocation inside the FPU region is illegal, while on non-RT
> it is specifically the large ones - two failure modes, one root cause.

I think this was true when commit=C2=A0
183182235f6d ("drm/amd/display: Wrap DCN32 phantom-plane allocation in DC_=
RUN_WITH_PREEMPTION_ENABLED")
was commited, but commit
04aa71da5f35 ("mm/vmalloc: do not trigger BUG() on BH disabled context")
changed the BUG_ON() in __get_vm_area_node():
diff --git a/mm/vmalloc.c b/mm/vmalloc.c

index c31a8615a832..bb6ae08d18f5 100644
=2D-- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3203,7 +3203,7 @@ struct vm_struct *__get_vm_area_node(unsigned long s=
ize,
        struct vm_struct *area;
        unsigned long requested_size =3D size;
=20
-       BUG_ON(in_interrupt());
+       BUG_ON(in_nmi() || in_hardirq());
        size =3D ALIGN(size, 1ul << shift);
        if (unlikely(!size))
                return NULL;

so on non-PREEMPT_RT kernels DC_RUN_WITH_PREEMPTION_ENABLED is no
longer required for DCN32 phantom-plane allocation.

Bert Karwatzki
