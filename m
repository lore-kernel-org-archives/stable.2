Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792500636;
	b=HCnr0EgUw57u8CvjjmEo6dQ9OqWCt1YNpRwy0A8Y+vD7U+cddtSOil/m87oyVwJ0IbYL
	 b7/Yns1uPJTGIW8BBRKfpqk0PZ5MVQrwRNaRdZ4LUoFb0wS6xs/Wj2wXZnX7Fn0m9VKJT
	 3iUnVhr4vO0cnHH819eeX/dcnxblhcRO8m8I25Wu2sbhThNKoqXlR7vQiUDw06z4qGJ3C
	 lQNB8t4BtsxSzs/oJ5VkSgzeC9sy0Omn9sVgD+QRMEous9AbR65/482JTlBso39ibsGO9
	 NSxPSAtY8AiN+sxddW9fjVVALoGT0H0RSQ7hV8E/BiImYFI14/vhQWzC4PFzdqBE1bA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=r2GFX3sHh1KRCB1444YP2uLVlY4It4wzUFS+sYA9Cdw=;
	b=qZrQX/1RqlUeBPSVosoNyLbm91ZGJE+u3exSOkym21cFDbR4USUDW4NfK1weEum4VcQg
	 ZDQE3rRXa5ySfmCVIeelAJLQNnACjKOS94rKW6POJ+8J63SUsmZYzCijCFtjiSXGjL0A/
	 q/spdotR9SGmOvpQQ1TGznSmwgVcORTFScsiKnmZhkwP20Hvo5raonvDeeYKQz5Ccye1m
	 jFw/AkkdKngBe1bEJlB35k0yU2Jb5WsO6jPNX+U3X49NmmtM6DjnoBjvnBOw1ti0Qf5BI
	 ZpRLQBi6vhNcNWs+aBd1hFGMV/OYQV43AUyalWlNZCueKkw/Q2e6iIjFMBqTRYxi1qA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UfF90Vim;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A83606A335
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 12:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59A83606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UfF90Vim
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-34c522572bfso326684eec.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 05:50:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792500635; cv=none;
        d=google.com; s=arc-20260327;
        b=Th/xNI3X38bL/Fo3BpEduQEHSP0rrbZSh9z2pNf+UtlTSW8yJMi4NH5wEnxTPQWb7D
         FctGCPchUxPA3BOoD1tDCr3REQ23NMo2BmJ6qsBOptQ9MSo3AnI6NBuuZdPXC5z9x1VO
         aCSnQi8kMgKgZbwQ4N0jxIei/fnhPobnYIdsgOJEDDdNuFbkF81PEIuTqM0+XH9PNhCV
         pmhaNhX1Rkrm7RDnitPmfWNsvVIPwFm96Qe2OGYgLBRVqQfeGvRMzMLeAlzNFU+TD7De
         4kvkfSULqLZbNFPvJICnWFUO8i4x0+dtu6A/6+Tsx4vyZFwxfsOPuqGUW4jMXwDpi4If
         z6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r2GFX3sHh1KRCB1444YP2uLVlY4It4wzUFS+sYA9Cdw=;
        fh=bSM/cFDLz8Y9Ai8R6aTPeL9m0NNt998e0SnLtbLowoQ=;
        b=byx53eEtF7jLqT/peRUKO2Jkjfc4eTW60TJnJlprZ0+KP41XFnrpdBkgtsT/vmPhiR
         Q84QIpzWuR2VUTYzE3vg1udEh0UzOk+pKcFqndB1fskgP9y+Y7HD8DvLgzVOIQpxigS3
         t4nUDC8nj+rouEmUbL8FdGEoqVADslz66+qxlGJQ3x40ZR7XjelOeuNJLhS2AiMBB4am
         xtLT2j95MV9CibSVcRM+mYePYllkUrtGs2zt/qgiSfIIWSGWNK+5gHHZ+zViDeaEeOww
         YyvLNoYYO9uJn0HNXOu8hPimHTPZ90cv9LkP5TCj0mf+Qk4mvSLuYKcSs5N7sCLO4zdz
         HASw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792500635; x=1793105435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r2GFX3sHh1KRCB1444YP2uLVlY4It4wzUFS+sYA9Cdw=;
        b=UfF90VimWdm3xhQ+Qya5e7krz1MMQku5aBvIMYxiW+RhS+0/VG/8/e5xBBNc2OV9tK
         nywUtcKCE0QrGLsWE/tGVSYnbH7fPF+wQLJ6nyteb5edVT+WZtpgpZdbiP2FBEZCr+Ix
         SSa4ec78aByv5DO2418oUp8u4SsIsBkxtcR65+Y7f/IeeTAFO8R3G0c9UPo+1zWcSheZ
         6/ipqVyF/vY6cC0u6eZcBcZzMdUQK7j5JWjPf7tGuN8BZ6ZhhxvhoujwV2Y/0S8MtXGw
         6KqTEV2MpfXP6RPomemgqVf2PEXsfTirVH8p6/A0ZOz2CSH9O+TGHT5A9iMLFchuksml
         YwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500635; x=1793105435;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r2GFX3sHh1KRCB1444YP2uLVlY4It4wzUFS+sYA9Cdw=;
        b=U8me1sWKDusoj3DRPWmRPTrAUoLTo6LO0Br3Hzlxi2X02Fi9p9fzF6PQVYvqDZDJsf
         lXUNLPsVIy/r3XsibW7O4D9izB1HzseidvKFNFmcAF4jU217ZvKTQnt3cNe+VUkCv08o
         u9f5w5SwjrX5V6poE+/RKV+vIPxUHsPviCba5xTH5aPlLVQUCTdYY1Pap6FXE1sPeOuu
         VQCQwlWjQ47BY9YsxFp0nqxHFw9f6JtpBgLNJn2p6vyuSxl2SaqzAS3KT+IqphL4YdF0
         L7O+Cj0sn+eHIMI8EQnCGSPlA2swh7CUIIf7RLbSKQNKn63nUWvvg2p4ks2+Jr3EqExO
         12zg==
X-Forwarded-Encrypted: i=1; AKwUvBzRDe1rIhroU4Qib7dPzLgOO5PMaFhMMLosQDKE7bYagOwfLQHsgZUomFZMowgJ0CBnJCp9cFw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmmduYi69ZLKUr66U2HmRHA1DSmsQIFFyN9+tm/zp99gAHBV8J
	1PCYqCDuR/BY0XqxPOUuK0hUIol9szxlJq4wHbgpzAL3CW6ch50tAuwRmAKh7beDn9aoFy8JLRY
	nzbI4ipL/oVIa9XSBdgAwmRMSvMYYpyKzsuwioOw=
X-Gm-Gg: AYBFou1oybeCtj8qxOBzVP6IOJvwae9nF3glf8dZJj7KlhfRrpNRORilyyeYh/xuQFo
	7cOe9xaHYTbWzVhRIihP9u5tr+99cppqwqgStTfRjqh8DDXgxLqZkjPOSorXQ/hdVQns+whX7s8
	598+u6G6ynfzouDC11DFM3HKgHA+PIKCUjb1bSSw1CVOtrMt4OG9IN9ZeqTWwwxrn+fjmiAFF5u
	llHVeTRxkRrqRheczIemrcBgVde8HuQOwtC0Gk0tZYdrPQi/Uy53MkHjfJSEFJ6R4G4njnnr9ew
	zmtGftEH5Ng3mEc9DP1z4hcvPW+7Mi1EKihGKswcvXcJC2SZngScW3gzMMWtvgtwLtABzgLWBN/
	aveOjFBsRu2HdAAiqkhOO6ziYxohGsGaNn2m9c2FIjXqNYOxOLNNejeaABI0GBmZxv1cu1dHA/X
	tmZ4cSCHu3LXu2kCrl60jkpcy+tw+I+BNe5KnQQ8n6KoaP
X-Received: by 2002:a05:701b:455c:20b0:14b:edb2:c3bc with SMTP id
 a92af1059eb24-18506e5ac63mr23192173c88.0.1792500635306; Tue, 20 Oct 2026
 05:50:35 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020-gmc6-writes-only-v3-v1-1-70730a302504@gmail.com> <36edbff3-fb61-4bc9-ac2f-0ba549ffe248@amd.com>
In-Reply-To: <36edbff3-fb61-4bc9-ac2f-0ba549ffe248@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Oct 2026 08:50:20 -0400
X-Gm-Features: AclHuK_rWC3C1b3gKg4AIEaR0gHppx4UYjUcnHdBYSrohQh-2dJwkEjnWtvuzTI
Message-ID: <CADnq5_PtxMPr41RgUEeEDOeXQDWVvse8=3WayZcHHE85NFj+jA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gmc6: restore FB location and HDP non-surface programming
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: drury.brad@gmail.com, Alex Deucher <alexander.deucher@amd.com>, 
	amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 7:40=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 10/20/26 10:40, Brad Drury via B4 Relay wrote:
> > From: Brad Drury <drury.brad@gmail.com>
> >
> > On a MacBookPro11,5 (Radeon R9 M370X, Verde, PCI 1002:6821), used as a
> > headless PRIME offload GPU with the panel on i915, every S3 resume with
> > amdgpu fails:
> >
> >   amdgpu 0000:01:00.0: [drm] ring gfx test failed (-110)
> >   amdgpu 0000:01:00.0: resume of IP block <gfx_v6_0> failed -110
> >
> > followed by SDMA timeouts and a failed GPU recovery.  The GPU stays
> > unusable until reboot.  radeon resumes the same card fine.
> >
> > Instrumenting the resume path with a write/read-back VRAM probe through
> > MM_INDEX/MM_DATA shows that VRAM is still intact after the driver
> > re-POSTs the card and at the start of gmc_v6_0_hw_init(), but is corrup=
t
> > at the end of it.  The gfx ring test failure is a consequence.
> >
> > Commit 71086a3e8470 ("drm/amdgpu/gmc6: drop fb location programming")
> > removed the MC_VM_FB_LOCATION and HDP_NONSURFACE_* writes from
> > gmc_v6_0_mc_program(), on the grounds that the vbios sets these up.
> > That holds after the system firmware POSTs the card at boot, but it doe=
s
> > not appear to hold after S3, where the card is only re-POSTed via
> > asic_init.  radeon's si_mc_program() still writes them on every init an=
d
> > resume.
> >
> > Write them again, with the same values as radeon, after the AGP apertur=
e
> > registers.  gmc_v8_0_mc_program() already does the same for SR-IOV VFs.
> >
> > Unlike radeon and the code removed by 71086a3e8470, this does not black
> > out the MC around the writes.  The old gmc_v6_0_mc_stop() relied on
> > amdgpu_display_stop_mc_access() to blank the CRTCs first, and that was
> > removed by commit e4f6b39e8bcd ("drm/amdgpu: remove *_mc_access from
> > display funcs"), so restoring the blackout now would stop the MC under =
a
> > live scanout.  On this machine the writes alone fix resume; a variant t=
hat
> > also restored the blackout behaved the same.
>
> Yeah that is exactly the reason why this approach here doesn't work.
>
> We can't stop the MC access nor the EFI access to the PCI MMIO BAR. So wh=
at you try to do here is inherently dangerous.
>
> I think we just need to do an ASIC reset on load like we do for other Mac=
s as well so that the FB config matches what the VBIOS programmed it to.
>
> Alex any opinion on that?

Should already be fixed with this patch:
https://lists.freedesktop.org/archives/amd-gfx/2026-October/154974.html

Alex

>
> Regards,
> Christian.
>
> >
> > It is not established which of these writes is the one that matters.
> > At boot on this machine FB_LOCATION and HDP_NONSURFACE_BASE already hol=
d
> > the values written here, but HDP_NONSURFACE_INFO/SIZE do not.  The
> > register state on a failing resume could not be captured.
> >
> > Tested on linux 7.3-rc7, MacBookPro11,5, amdgpu.si_support=3D1
> > radeon.si_support=3D0, mem_sleep=3Ddeep, with this change alone on top =
of
> > the stock driver:
> >  - 7/7 S3 cycles clean, from a few seconds to 10 h 49 min asleep, on
> >    battery and on AC, including two back-to-back cycles woken by the
> >    RTC alarm
> >  - DRI_PRIME=3D1 glxinfo (radeonsi), glxgears and vkcube (RADV) work
> >    after each resume; no ring, -110 or reset errors in the log
> >  - cold boot unaffected
> >
> > The variant with the MC blackout passed a further 6/6 cycles, up to
> > 9 h 40 min asleep.
> >
> > This patch applies to amd-staging-drm-next with only a line offset from
> > the tested 7.3-rc7 change and has been build-tested there.
> >
> > Not tested: other SI parts (Tahiti, Pitcairn, Oland, Hainan), and an SI
> > dGPU that drives a display.
> >
> > Fixes: 71086a3e8470 ("drm/amdgpu/gmc6: drop fb location programming")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:claude-opus-5-5
> > Signed-off-by: Brad Drury <drury.brad@gmail.com>
> > ---
> > I can run further tests on this machine (MacBookPro11,5, R9 M370X /
> > Verde) if that would help, e.g. register dumps or other variants.
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/am=
d/amdgpu/gmc_v6_0.c
> > index a7c353d1a..d6e315f4b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> > @@ -223,6 +223,17 @@ static void gmc_v6_0_mc_program(struct amdgpu_devi=
ce *adev)
> >       WREG32(mmMC_VM_AGP_BASE, 0);
> >       WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
> >       WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
> > +     /*
> > +      * Don't rely on the vbios having set these up.  After S3 the car=
d is
> > +      * only re-POSTed with asic_init, and without these (as written b=
y
> > +      * radeon's si_mc_program()) VRAM is corrupt by the end of hw_ini=
t.
> > +      */
> > +     WREG32(mmMC_VM_FB_LOCATION,
> > +            (((adev->gmc.vram_end >> 24) & 0xFFFF) << 16) |
> > +            ((adev->gmc.vram_start >> 24) & 0xFFFF));
> > +     WREG32(mmHDP_NONSURFACE_BASE, adev->gmc.vram_start >> 8);
> > +     WREG32(mmHDP_NONSURFACE_INFO, (2 << 7) | (1 << 30));
> > +     WREG32(mmHDP_NONSURFACE_SIZE, 0x3FFFFFFF);
> >
> >       if (gmc_v6_0_wait_for_idle(ip_block))
> >               dev_warn(adev->dev, "Wait for MC idle timedout !\n");
> >
> > ---
> > base-commit: f307e9d20cc7bd6dd54a3fd8c2af767dd7ef2931
> > change-id: 20261020-gmc6-writes-only-v3-33151aacabfb
> >
> > Best regards,
> > --
> > Brad Drury <drury.brad@gmail.com>
> >
> >
>
