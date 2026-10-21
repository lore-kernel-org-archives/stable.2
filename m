Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792541311;
	b=VvAyqkIFOeinXPs20VXxpiB6f2fXbQtwRTYkCKKwW/bxRbpui3DpGfoW8GsBDWF3IgY1
	 dCx2Qnw3Al3JytZBbPrSDA7kFkmIdzG0nh36YmSHPkK4jjR8Uqi/ATT5axRg8KQWRuteO
	 rvlujihXBtPwV9jksGqumPFxHRPlZMXU9Z+LAiAz0Qmf31psRjqWYeguGgHw8etG5E831
	 u4CybPj5aFJZrsk4FRH7IcMxaf03qYbjMy9swyrjX76S9yTKMgzoBpkPXjxcQrJUv+NN3
	 fjaxR6/hPqze2JYX73klY5exffz2SBZRUo+IKqiADeTMMz5FVHzE/lPvRa1lN44+vJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792541311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:From:To:Subject:Date:Cc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=q76fPd6I+9oLgbQ4WW7J9EoxVAQOgPqIoUvr4JNR1bA=;
	b=N6el5llIIRbjuqQZxQYWLL12rOMPMfi09LfBEl5K83up6Mt9GCEl/PZqPvMe3r6/Juld
	 gDPHiSCHcfBtqIVfelIjPcip+N67hEJbw+lp/lGyxOj/B/5tzCb+BA6Ig1bjLJo9T9CZH
	 CIqajyLkzb/Y7NYawD9648Nn6FdrMDlERHx5O2OLKvNKgoSzpJtFwNHZ5p9luPwc3darg
	 4+KzSFXe1fLSHW+/1BNQhL55Kw6bnJaDuQREvQVD3JXyr3CtaeDoKrL7u/uO5NC2jzjSQ
	 ORxAiNM3GN4AqrGKBE6Xfsf7etE4C5ZP5bi2DGb8AjSPScOATVxTTKD/ylT6AYfVtng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utexas.edu;
	spf=pass smtp.mailfrom=utexas.edu;
	dkim=pass header.d=utexas.edu header.i=@utexas.edu header.a=rsa-sha256 header.s=google header.b="il6YDP/4";
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D45606A320
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 00:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00D45606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utexas.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utexas.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utexas.edu header.i=@utexas.edu header.a=rsa-sha256 header.s=google header.b=il6YDP/4
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-843cf077f10so250520a34.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 17:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=utexas.edu; s=google; t=1792541309; x=1793146109; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:cc:date:subject
         :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q76fPd6I+9oLgbQ4WW7J9EoxVAQOgPqIoUvr4JNR1bA=;
        b=il6YDP/4MWTaE9oOQd29crSa0vn02P2eqibmeGX38ROUktudUqJdcUa95VncnY3tVB
         aOyJfnJETgKmVcdlTdlB9BZS7lyCuGws4QsAthBzdIOAwtzYbEpfUAzL+pnZ0g5QRh70
         b7YOIKlilcoeaAEevpULEfolsuQObT1IwmCIp1MYMvNg8KY6zaIWpp3K2zF2JFJU4rch
         glgy2kUenOxtK843TFra8hKMVm7g87U1B/x+7EzJd7CeMnh46pKMo/14EpaMjGU5IdkN
         i0EEFF7disU8PCdSgTZSv+YnrWca8T6XHvrNKiHHK6gHE6r3SA8c4lkbKtBHVcqysAdg
         3SeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792541309; x=1793146109;
        h=mime-version:content-transfer-encoding:content-type:cc:date:subject
         :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q76fPd6I+9oLgbQ4WW7J9EoxVAQOgPqIoUvr4JNR1bA=;
        b=P6vjGuoq0pldD7m/ly4RHENAk8cgZuy1/AxiMDBwnSXR1n5ai4/4SB8YVPJTXOVt+w
         1sy9YYMR2pUOIsiPe8vzmisAAIelQz8kzZKOnVB3KbGBI2i1z4816lA/qlr2KmxIfOXt
         KQe6t/V7NEvGohrv+UPoXiGTBzt1F2OGUw1urfUWsPQD4HtQ6oPfan52A/tS7NCFf0sj
         o0k/5DHXPBUnt1Lt+QLDGIblFDoNNU5XWv36I0mow7kdOGN1NSHxXxxiCvbJbdrA3BtN
         rsFfnYMWH7wBShXAy6Ep5OOT5YI7/Mph1mW5WSYv28aF6hU8klO5X12VqdBD0LWIZnMk
         1yHg==
X-Forwarded-Encrypted: i=1; AKwUvByGpQtC7I1xJasEGrhnhs/p+mXnyOtBjIEapXQxSJ/yOeht3EF3KCUTtDOUhznkpvSCn4JDLfw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLlDZldoT49yrk4X5gk85j/2d6nwaN5d7p1ZqEQDYUxdJLON3ps
	JExSxX/g4hTItN2UOV1VVMc/dUdPS06XXHTCIUahxvDVEy7ShCPiLKvJBpvqSsBA23Q=
X-Gm-Gg: AYBFou2/eq+pdazyBmz8LuoJh56NGqwv7wDKRwwANJbNieANCjL3BM3IqJgtZoq7maE
	ZKyYL+hABl8Jrw53R4D4N6+zS7V0hwJYaK2kBhVDUeNmPEnIsLiSMtDAiu9bx7R1Dca0o8woOlz
	H4dZl9AnXfveyx05FnEsNSlOTq24ndJeKLTsYNTakSfT/Ba6vrAvDqeQiDR2a6HYUCqcpa/C+2D
	wwKo9Y7THAIWfzWiePtrtvlSac0YkyTHAvvRZSVcOxQ+Jpx31VC/GgbxdFFWNa11vMBkCIb9DWN
	v7fwznRov3IjJk+EpMhij1MN/Bar4630vuJG6Jizp667o+bh/oui2Ef1XxzWToDIBORkIEI/Nze
	hrrbOhHRstvRgv8gKUE4B0CPMjc+1Caez5T3VTVXRVYUiN9nKT4LI+U8FtBEi1LyuMU5kJGxk1D
	XShGgJVLVDgbUg6q4gxHUqmfBv6/xRBlAKGYSVPggidwKwUDNPMB7tbGlNhCgyHoYez6edxIpzN
	CwIM50Ur3rARfFwspeAufn+bpFe2bTzHzFiwNxraeR+WIKEStEThXTsUZwk0gssnSViztNbNjeY
	i8pX0GzVYPwsizGBra6TrXTDEUiTJXsYWYPSrBXIJhC/KgFkJx8xmkkpw2cZCRVzoxW1Xz1lJG+
	XoLg3vbk01lrlqUEVQQTkj/65wyqdcc7TRYaI0xcSbTWc5KXh0srHEmHk1zdsY8Sxj6cmICGgzE
	s6RURqULYSKbjc6eTWIg==
X-Received: by 2002:a05:6830:4425:b0:81c:37e2:2012 with SMTP id 46e09a7af769-84d07f09896mr256325a34.15.1792541308869;
        Tue, 20 Oct 2026 17:08:28 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([173.174.112.101])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbd7d4431sm955195a34.19.2026.10.20.17.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 17:08:28 -0700 (PDT)
Message-ID: <6ad8027c.7f7fe2b9.10c6e4.4073@mx.google.com>
From: karim.sabar@utexas.edu
To: Matthew Brost <matthew.brost@intel.com>,
 Thomas =?utf-8?q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH] drm/xe: Use kvmalloc for the VMA ops page-table update array
Date: Tue, 20 Oct 2026 19:08:27 -0500
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Karim Sabar <karim.sabar@utexas.edu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

From: Karim Sabar <karim.sabar@utexas.edu>

Big games die after every s2idle resume on flat-CCS iGPUs. The exec
ioctl keeps returning -ENOMEM even with 11-16 GB of RAM free.

On suspend xe_bo_evict_all_user() evicts every user BO in XE_PL_TT on
these parts. On resume the first exec rebinds every VMA in one go and
xe_vma_ops_alloc() kmallocs one 384-byte op per VMA as a single array.
Final Fantasy VII Rebirth has about 33,500 VMAs which means a 12.9 MB
array. It's over the 4 MB KMALLOC_MAX_SIZE and can never succeed.
__GFP_NOWARN keeps it out of dmesg.

Data from a Panther Lake handheld (SteamOS kernel 7.2.7), kretprobes
after resume:
  xe_vma_ops_alloc  -ENOMEM on 63 of 63 attempts
  xe_vm_rebind      -ENOMEM on 63 of 63 attempts
  BO validate, TTM populate, PT prepare  never failed

The array is only used by the CPU and doesn't need to be contiguous.
This switches it to kvmalloc and kvfree.

With the same change applied as a module on that kernel, the game
survives every sleep I tried with zero ENOMEM. The biggest array was
30,753 ops (11.8 MB).

drm-xe-next already does this through commit 0e33330f1238 ("drm/xe: Add
struct xe_pt_job_ops"), but that's part of a big series that won't go
to stable.

I tracked this down and tested it on my own device. I used an AI
assistant to help with the debugging, i.e the kprobe tracing and
reading through the xe code. I ran every test, picked the fix and
reviewed the change myself.

What I couldn't do: this is build-tested on drm-xe-fixes but only
run-tested on the SteamOS 7.2.7 kernel through an equivalent module,
not on a mainline kernel.

Fixes: 2e524668c440 ("drm/xe: Add xe_vm_pgtable_update_op to xe_vma_ops")
Cc: stable@vger.kernel.org # v6.11+
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Karim Sabar <karim.sabar@utexas.edu>
---
Downstream SteamOS report with the same data: https://github.com/ValveSoftwar=
e/SteamOS/issues/2962
---
 drivers/gpu/drm/xe/xe_vm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 99e42bd29..5caef443b 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -703,9 +703,9 @@ static int xe_vma_ops_alloc(struct xe_vma_ops *vops, bool=
 array_of_binds)
 			continue;
=20
 		vops->pt_update_ops[i].ops =3D
-			kmalloc_objs(*vops->pt_update_ops[i].ops,
-				     vops->pt_update_ops[i].num_ops,
-				     GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
+			kvmalloc_objs(*vops->pt_update_ops[i].ops,
+				      vops->pt_update_ops[i].num_ops,
+				      GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
 		if (!vops->pt_update_ops[i].ops)
 			return array_of_binds ? -ENOBUFS : -ENOMEM;
 	}
@@ -742,7 +742,7 @@ static void xe_vma_ops_fini(struct xe_vma_ops *vops)
 	xe_vma_svm_prefetch_ops_fini(vops);
=20
 	for (i =3D 0; i < XE_MAX_TILES_PER_DEVICE; ++i)
-		kfree(vops->pt_update_ops[i].ops);
+		kvfree(vops->pt_update_ops[i].ops);
 }
=20
 static void xe_vma_ops_incr_pt_update_ops(struct xe_vma_ops *vops, u8 tile_m=
ask, int inc_val)

---
base-commit: d2ce8fcd778ee6d92748c92d23a56d4416c29d86
change-id: 20261020-xe-kvmalloc-vma-ops-2637ebf81cfd

Best regards,
-- =20
Karim Sabar <karim.sabar@utexas.edu>

