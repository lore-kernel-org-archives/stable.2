Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718336;
	b=u/pfKzI74bgMuAIGeYtv7dyqz8UyyOE7HcxhD+kCoqhZP8KQ/+ljCokpi/t7AN21s8C7
	 oHA1aliVuRATZf+49T+cjppZ2oq9snb+dDtnoZjLrnciK/Wc4BqDxL1BxAvAe690YGXMr
	 7hMvhK10te1QlTM2Hccnt2I4uIkFn3oG7T5huRV86skVbnwJhASZ3o8U7aupvGiXIS4ym
	 ADMGLRqCx02S2PXVoX0dFPy8zsECLYoE5U75YgHqeHbYqPoVD0ofyzer80WTa839QaMy3
	 YoFYYvYwcl0ar1kd1PB2a6nJkvFZaOTkv8tQCFt543te2t3gHYYbZbtLNlH7fAHedFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=CAcBNNgtM+ZvWYSpLVQ97i1PIWmRHPAQ5ZZNdGofiV8=;
	b=eYPdW+85+pJhOl4kxT41JODs4aAFXXj+wwVXyJkoohrZOprPnETtTyc6hYn/xIsk/ULD
	 Db0jv5kuxHdxDhCXy5hbzFj30+a246ihhnHl4tPK0GlwOKN0h+gymGt38kgzR4/GfX/xo
	 W/Ej2qvq4gTf4KIA4oxhihG86w8ThxAavx8aqiuP+XDffXZ1u61k2SDEch3gMB0qMZig3
	 y0177wHvec2jgmzq20Ei1upzNMCcTjLW5n88AaP8mfkQdB/t470cRRK5tIYSu8m5i1U4a
	 MUolL9YhAh/v0TxL6+mA1fH3Zfh+4edPoY0DKnG5haKKAAXccon3LpBvP4RjZqkA3eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Njrm1HjP;
	arc=none smtp.remote-ip=209.85.160.52
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B3B606A332
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4B3B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Njrm1HjP
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4a77dcc4ca0so2334772fac.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 07:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793718335; x=1794323135; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CAcBNNgtM+ZvWYSpLVQ97i1PIWmRHPAQ5ZZNdGofiV8=;
        b=Njrm1HjPUTcNgAw03tqAI/HECLjGLvEaKlDNPg7QY8qXqj2NqRlLs6JW3z+MM5Y+H9
         bEevl7SMVamQjPNGz4jNzvK8wOeT2s9YiRiIAQvFWebSznRH7i45SHxK82aMzWt7q7XQ
         AJwxn02fcuJdNKnAO0tunrff8wXoEqtTPqvahYpFvvD7F+KdEbLsTpoml0fJrvkoCmIU
         AI4kIJ+MQkWbYVPwwJCqlJstndAweGD4/0pQRSj3Jf64/Lh8jSmOGqVRJSklECU3CuZQ
         +/je9xDNp6EhIFWCAiE1p7e9/1puFemv6SSKfU/tj6mmHhWq8j7OrzgtPIB7SGQDomZz
         2T1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793718335; x=1794323135;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CAcBNNgtM+ZvWYSpLVQ97i1PIWmRHPAQ5ZZNdGofiV8=;
        b=s4jqaXLnexI4db+ZxCW33WGHk/Tht4U8ie0bMnAo48LgpCgMq70AQwQS2uv//qvQV+
         p2YoEh86mBBw0gptvPsxWklZY1KTJZk8kUGbvXSpLbMfRToxTlLCKrJ/xnHotCTyvm63
         bhE5FVCK9/rwiW9MZlfKSu8tqAnpSeCJXibeZopucrEKHQUWODacJ5NJgyF/QhR2o4y5
         YFG37+ekkQg+VFl9Mg3cQY6b86QGK7ZBp96vNY09gn6YshJioZxFRgRSrxop6A8wN1Bb
         tbH1qrLLl7OepJlAEBiFuFNKCgV9ImWTyEnacVChJ1qbKLkthzwzNTyT942czVmRvD4M
         LDfw==
X-Forwarded-Encrypted: i=1; AKwUvBzuN72D30mN4FPWrudWv+zdoFmC78U9xfO9MyqM3CizwCrmyvctWsK4WXXWcuH921/syLpBq0I=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1ZwlCLdS3PlPo8m7d0zcN+/ObCRhtCODFaa1iAaME6hiDBMro
	pgQU11Fq8tovUt0v3AD/nTuBquwuBnVJK/4xnQ+lWkT35QrL0As0VLSIpctoQ69rsso=
X-Gm-Gg: AYBFou1oqIzj3Qz+VBXBFLQpJl5STGfQ4GwDr43xBiqYoITTKV7aM9c54VjAUqbZPJ0
	NKbTqUG/SlWrEy4cJC+bacVshdU2f72zFZ33fXHPrWaJYmAQTCCSOGPK6VeHys2Urx9qlcbTgzh
	1WfEGdGzoqxMuyIm6f/dkPrg7OTa1wcCsEGS1tgdNF8U6QgioD/Mct9aAakAdb9XyZ2AtL/M5lN
	NLQoQTBwbuzg19TGL4hGvNw54UTTivtO0AgRpDsBfv63h4yGJBc8ZdSvjAaS5FyP6KgqCR8cyyx
	HOLlmn2aJzEbSjjrR1FGSis5/XvagJ7Osi/xkt9MDQrfL1ZEhwLDR1rBa2czTeY9kziExJMX8dy
	B1DmveZmp0Aba7X+WvkhShda8+c74n7EbBYuoH02T3lUMkAcxXRO2j9RiVA5QeOYp1+j7gqhrTl
	oLF3Qq1D30oXLQT0ixpCxu4kYc81Hk1HL5Lu5hdsF1VjaPEZ3ufcw7XzL1Dm5B82csoZsztnZgE
	2QtwiP1Qw00KQh/IuLpH+RO6iAZFl1z4M95wOYhWgaDCEooqpNU/HW+v34Nh5ezC29W9Y7aj+e6
	e1anawI08cVPr1YnWhd7wLcQIvqg0G5czMdaA4LMxBS7
X-Received: by 2002:a05:6871:384e:b0:4a7:41a2:c208 with SMTP id 586e51a60fabf-4a9072d3f12mr8058700fac.8.1793718334420;
        Tue, 03 Nov 2026 07:05:34 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a92196578fsm9899101fac.7.2026.11.03.07.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:05:32 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 0/5] btrfs: data integrity fixes
Date: Tue, 03 Nov 2026 15:05:15 +0000
Message-Id: <20261103-b4-btrfs-data-integrity-v2-0-577dc2690061@toxicpanda.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACz46WoC/3WOQQ6CMBBFr2K6drQtCMGV9zAs2jKFMdqSthKM4
 e5SdOvyTf68vDeLGAgjO+/eLOBEkbxbQe53zAzK9QjUrcwkl5XgsgFdgk7BRuhUUkAuYR8ovQB
 1fSr0qS44t2z9HgNamjfztf1yfOobmpR1eaFVRNBBOTPk0308buKj9QEczilvBorJh9eWN4ns+
 pUU/G/JJICDLbtSNFVdCKwuyc9kRuU6dTD+wdplWT4Nbzu2+QAAAA==
X-Change-ID: 20261029-b4-btrfs-data-integrity-eb753b57300f
To: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Qu Wenruo <wqu@suse.com>, 
 Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Zygo Blaxell <ce3g8jdj@umail.furryterror.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793718330; l=3538;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=XlDEGHFbM49KCz7ZH+2JAfrfaW5E0Kl2m6LDPE2cOv4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDBdeCJ5kN9b7GPhOgBvlbx7ZT05gucHigMMiLz1iq5s6z4hsdFt63nsVxU4P8awUt/3yLbztVQ
 bU8fipRM1SQk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

v1: https://lore.kernel.org/all/20261030-b4-btrfs-data-integrity-v1-0-f4d4196731e6@toxicpanda.com/

v1->v2:
- Rework patch 3, now "btrfs: wait for ordered extent IO in fast fsync".
  BTRFS_INODE_COW_WRITE_ERROR is set after the end IO handler clears
  writeback, so a fast fsync could still miss it, for plain write errors
  as well.  Fast fsync now waits for BTRFS_ORDERED_IO_DONE on the ordered
  extents it collected and checks BTRFS_ORDERED_IOERR, and the inode flag
  is gone (Sashiko, Qu, Filipe).
- Patch 4: use DEBUG_WARN() instead of ASSERT() for the check that can no
  longer be true (Filipe).
- Collect tags.

--- Original email (v1) ---

Hello,

I've been doing some model checking of our trickier paths with Claude's
help, and these are the fixes for the bugs it turned up that actually
lose data, or tell userspace that something is safe when it isn't.
Every one of them was reproduced in a VM on an unpatched kernel and goes
away with the fix, though the fsync and log sync ones needed a delay
injected to hit the window.

The worst one is the fstrim one.  If you run fstrim while a device
replace is running we'll discard everything that has already been copied
to the target device, because the target's alloc_state is empty until
the replace finishes, so the whole device looks unallocated.  The
replace then finishes happily, the source device goes away, and you're
left with zeroes where your metadata used to be.  This has been around
since FITRIM learned to trim unallocated space back in 4.3.

The split bio one is similarly nasty.  If the last piece of a split bio
to complete is one of the split bios and it failed, we drop the error on
the floor, and a buffered read returns success with whatever was sitting
in the page.

The rest are in our error handling.  A delalloc failure in the middle of
a folio leaves blocks dirty that no longer have an ordered extent, a
fast fsync after an error that happened before we submitted the bio can
log extents that were never written (which log replay then happily puts
in place of the data that was there before), and btrfs_sync_log() can
return success for a log transaction that never got committed.

I have a cleanup series for btrfs_sync_log coming, as I had to spend a
lot of time grokking that fix, which is a good indication that the code
is too complicated.

They're all independent of each other and tagged for stable.  This is
against for-next, and it also applies cleanly on top of Qu's
extent-by-extent writeback series.  Thanks,

Josef

---
Changes in v2:
- Link to v1: https://patch.msgid.link/20261030-b4-btrfs-data-integrity-v1-0-f4d4196731e6@toxicpanda.com

---
Josef Bacik (5):
      btrfs: don't drop the error of the last split bio
      btrfs: clear dirty blocks after a delalloc failure
      btrfs: wait for ordered extent IO in fast fsync
      btrfs: don't report success for a skipped log sync
      btrfs: don't trim the target of a device replace

 fs/btrfs/bio.c          |  9 ++++++---
 fs/btrfs/btrfs_inode.h  | 10 ----------
 fs/btrfs/extent-tree.c  |  8 ++++++++
 fs/btrfs/extent_io.c    | 10 ++++++++++
 fs/btrfs/file.c         | 52 +++++++++++++++++++++++++++++++++++++++----------
 fs/btrfs/ordered-data.c | 31 -----------------------------
 fs/btrfs/tree-log.c     | 20 +++++++++++++++++--
 7 files changed, 84 insertions(+), 56 deletions(-)
---
base-commit: 2789b2c034d7c0c8687355921a38c5ac41a565fa
change-id: 20261029-b4-btrfs-data-integrity-eb753b57300f

