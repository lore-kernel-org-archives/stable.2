Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371110;
	b=u3SnHI8Y4ttB/aT6vjV/MP/lJPDjg/hvauX7GVy1rL209y9g4snNBczUqpiBIVUdMqrp
	 wb/QAjP2k/2WViEU2IX826nMtG0kdgphrbIKDRdMGoRPjc/JuvnygS5QT0kz549Xzrl15
	 AS6nGAgTRHaPkWNpRg+d31kMJxJaVgnkRiAhbJ3XaIl6Pz+hWhfl4cTBg4KPQtz5th4/c
	 pjkJ7LUHy0NLYNJprCaPnUBwmIL8dvMLl2xreF0qqpofOwAQW7oNlncgeyHDGQE/SPopH
	 JrivlgBPKLcSpAxskithjOasKFYJ9Pl6RFg7JE5ICU7YGq5xVOu6IGlpKlthct5l0QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Lw2XTa0UHLp5uC9FUZa5RGPGrr4tiBPXeAThucLJkgo=;
	b=nsdUcEPoI2GiahgeaPrGNFViFpamQl0tZvV6BoCGaxFm8008FIDfqvCX5JnNSLthcAGH
	 pFCcno2d2tdib0p2BbuMxcAd7zIEnym/dWRc1ZJA6OzDLTM8PbsBp3zAbyhMU/XnHvD+N
	 Vxl5hogjwT8ajlwRzlagmSTF3eQETHjkXfMDgRea4IqFChhcSGXVQ3HF+z1Xo7m5+mUYS
	 iTjOhzG3lr5RW7c/OShHceVQz3y1BMW+kQn7loOK/dsdB7i+uZaPGElA1o/p1KqaSjxTy
	 eONJhfg2mbmaOLC3Pzp5P2F76KRVCBvdqo9byrrxIW8twasknRMXzsqEKa1VfmAEYMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=f4Oxqytp;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DAB606A323
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 14:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7DAB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=f4Oxqytp
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93f1ca4132bso69437285a.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793371108; x=1793975908; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Lw2XTa0UHLp5uC9FUZa5RGPGrr4tiBPXeAThucLJkgo=;
        b=f4Oxqytp3QWZ8rkKm7Zakqilbipdp4cRSVRQyeZ7T/X+ekYhph4OPeKmzKK9hJADW7
         Mk9LhZfE8Vk0i9cVnh0j0qE14D7+07VEfzkYULnm6heiFkQl8aYPsGi5PMpNAJedwGKs
         I+EhFx8t61+b6IJQgrmOvGEigVJTlyTdl0XsFLDDq+hA8Ihf6kgq2mdch5nQkNRmI67x
         WAGZKLneKwbs3xuXEJR2nSPOJ0pZcO415sO3O/z8jKYCc6eNh2MEZ8aH4CnUfgOb3Qwu
         kKCgMEq9k0RlqD+5zX1zkIyYK6caNXNIw8N0t8xyjTHdLR9E8Af9uEHrKXRnPLrYrmB0
         FP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793371108; x=1793975908;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Lw2XTa0UHLp5uC9FUZa5RGPGrr4tiBPXeAThucLJkgo=;
        b=xdGVjvWkaohcaeLUlZnkKNYFe/UdELFHXgKSoamiK5ir0lJHDQb+eMyVzlzNku4JNP
         lgn3aRecdyIPeVYNRIukv2A1hiCm6q58jeXN1NHv2hwahahYeljbQiwlfmlJzXZZBDco
         nSpo5SSBUrB1Ef1Gg552G6DzsOX+5B/2lD9Nx2b7VCCanC7sKtyiqv6mJyyfR9S0DyLS
         qmmfQVVpD5p7B1WFb8Z7wlr4TvLFnkt5G1C5zpprRr9XL9UhMp6QWKvr3cKiGdQ5hrXV
         s8RqLK++EWswn2MdjV+2iWz8u225z0Jtg6hx+2m1XhdSu3TvioxRU+dDt6ccl6uS2nja
         NrvA==
X-Forwarded-Encrypted: i=1; AKwUvBxe+K5JdsS2uouk5U3+FNNCAqLBVjB07pkS6hnuIkKPfh7lQjWND4Lwc4/gm0a8i7z6KDwd8hs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIA/VVQ53upZ77eqZFiFMB3Km9LILrZOiDivQJcK5nYSakPB334
	24gv3LGzmAvUzPdPnBoA6C161Io4wZJ/Lg+B6KclIvQ+d3prV2MKxrqV9tNMfaMj3zk=
X-Gm-Gg: AYBFou1NXE5AFXJZm49P306MbCkYnw6GXPQrCZFMlm7bQVX8+awa9jZ7bXqtdwnNGx4
	HX9PTyLnbqcQj+Oq3Q5S1I2fknAUp2urSB5heRsrU70FuIfDVLTRFuQnSoBAvH6zhXoSAzmR2EB
	v0hk/cuUR9nIwLWE89uo8ps09J9NRZoYiE38aHp4pH0kCjfrN8rfhwd+/YcxgQlEevaUQBa2C/5
	dSL/lUM5BrAaXVN7rodOL5riEl02XsvrfBD8oNRotMam6HXY6pIBnhr/8MeUyjkplS11pBUxCQI
	jSTJj007OruUbx48HCMTAYxEMitZ6W0W4kyUp8rm2E2wU642YpLy9n74OYbU6gN5pc4/AcY8aW3
	YKxbGMQrUbPwakvzGPhw5MKUh66aSMPagHYbw5JTJXQ0+vOfmklLjY2LZGY1P95hcPQD+58Yqn+
	SGacK9R3Lkr04gS1z5Ie/US4jZO2F5uZPgR9y52LkQDOL1s2P7G4Y7lLYiR9KKa12Gv/FCaWomT
	2Ifh0mKM3Qx8SFEBuea761u0utopk1iRrGyiS2W7iq7ykQGpeYJt1YxIRI3yZ9R1wzivI2He2YJ
	HeRlJ8ymMUHBGycbnBAhGq2bEKEu4hJ6HZHRJPPJc0we
X-Received: by 2002:a05:620a:8907:b0:939:6de6:9518 with SMTP id af79cd13be357-944216ed973mr439727385a.47.1793371108304;
        Fri, 30 Oct 2026 07:38:28 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425ac6bddsm155612385a.37.2026.10.30.07.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:38:27 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 0/5] btrfs: data integrity fixes
Date: Fri, 30 Oct 2026 14:38:06 +0000
Message-Id: <20261030-b4-btrfs-data-integrity-v1-0-f4d4196731e6@toxicpanda.com>
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
X-B4-Tracking: v=1; b=H4sIAM+r5GoC/yWMQQ6CMBBFr0Jm7YRSRKJXMS46MIUxppBpNRjC3
 aW4fD//vRUiq3CEW7GC8keiTGGH6lRAN7owMEq/M1hjL5WxV6QzUlIfsXfJoYTEg0r6IlPb1NS
 0tTEedntW9rIc5fvjz/FNT+5SzuUHuchI6kI35uk1l0e49JNi4CXBtv0AMY9XBZ8AAAA=
X-Change-ID: 20261029-b4-btrfs-data-integrity-eb753b57300f
To: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Qu Wenruo <wqu@suse.com>, 
 Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793371105; l=2635;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=YMEJ1FGA0t74fOXTrNLI1MmSNUL5joiB2lJWMWavJzo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QB4FPscSuuXStZNYYoP94AQtart+lZVJkTi0PEYHBO5lthR/+x60yAWTI5WRWLxqncxocpaCo8K
 2txIaK+CpUgQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

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
Josef Bacik (5):
      btrfs: don't drop the error of the last split bio
      btrfs: clear dirty blocks after a delalloc failure
      btrfs: make fsync wait after pre-submission errors
      btrfs: don't report success for a skipped log sync
      btrfs: don't trim the target of a device replace

 fs/btrfs/bio.c          |  9 ++++---
 fs/btrfs/extent-tree.c  |  8 +++++++
 fs/btrfs/extent_io.c    | 10 ++++++++
 fs/btrfs/ordered-data.c | 62 ++++++++++++++++++++++++-------------------------
 fs/btrfs/tree-log.c     | 20 ++++++++++++++--
 5 files changed, 73 insertions(+), 36 deletions(-)
---
base-commit: 2789b2c034d7c0c8687355921a38c5ac41a565fa
change-id: 20261029-b4-btrfs-data-integrity-eb753b57300f

