Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501475;
	b=re/Sz8Z5yjLMLhkXhl2KnzNW8HCnlac4nNq4ku706MszVhrJT9qZLz9iViCoq/9cYikQ
	 Jo9HF1Ea5RP9gJXMMVX0FGLuKm25F0fFYozNAwNUQlsXIsqJo6FufciFP2sgIvO7rR++1
	 E/3hVvAEnGPiCMVNc52EIqQGqgleAWlditRH6SS4s3rNP9JWxOozsO0rr5a1yeeRsltMY
	 qcLszOsFB33eHkgdq/qao6NmAO63V8Ewu9rQhwbQoAfe4Dp8VyVc1d/OctopsxRH3UEPj
	 TnJkjcqZ3yEsJwmYIXIp84VMenS5cQQeJ+EMWhzppf3hGmMjNguJ2gPjgFcW/cTSMxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501475;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=jCZcwaVbEXSO6fmP+AQbtigP75VIYTb9aAjDi7oBhe8=;
	b=sapR9csF0QTLBibpBehDZTIjQGEPL6cxnPNTK36hoDLcCnZ6cMh4lwVk8lh5yAUghG11
	 vWpJAaXo6apupJRu6k8IxAb1jGB6Xmq6yIDabDHsBbFCZruoqKlli9w/756sGRiJvGW8U
	 80Fu1H9laa3ZMoaoxRjFzT6krNYaqIBA4eGBU9qMa6rTTlvN8vXxR1NTThd/x6g7R958X
	 22xmMnBxqOPDq2ZuR9Za3QyzWQVWDyYyrO6AUN97KOWJGUcWjTMg/GTJkQ/wromoNKNf/
	 XUkg3Cr+0mVQTNYiHEQhTR7O7VEDzwqwzKvn0+g2ibJTXqfWAeWMW0zxOpEdilC9Wpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2ksWvqT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AEC606A31C;
	Thu, 12 Nov 2026 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2ksWvqT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527B61F000C5;
	Thu, 12 Nov 2026 16:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794501474;
	bh=jCZcwaVbEXSO6fmP+AQbtigP75VIYTb9aAjDi7oBhe8=;
	h=From:Subject:Date:To:Cc;
	b=j2ksWvqTjSpZRpEsyTzmS8gn1fYVO4+77jjtVD2TTFlIgfkVQlOk4zXryc2kB9+JC
	 T3OtQ+rN/tMSqHZomvQ/G5Cx/WXIMv3mMEYGQ4qvgX8LiABhA8sQK0N6QYHi7Fsp4e
	 Hk2pUwIxYgFmsDpRsRCOCGb79e9HTkdNFz9F9ThBcu/ofn6qdF/vOYMyi0NhEk2ePx
	 zyjSDNgbA4HYZWd2NgF4NUeouIylYH4zt8BRnBbYz8tK66jZQcBHuvxyulHFFfvNoQ
	 HvYmM4CcWOgiMGC6XGwj7KPtbncI/6XyGlUbOREprjSfMgxNUVuKQRC+//pxEYh94L
	 81/mSZ987PGpA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/4] crash_dump: recover from machine checks in
 copy_oldmem_page()
Date: Thu, 12 Nov 2026 17:37:06 +0100
Message-Id: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMSw7CMAxEr1J5jasmC35bJA7AFrGIU5cGaFLZ/
 KSqdyehy3kz8yZQlsAK+2oC4XfQkGIOZlWB7128MoY2Z7CNXRtjLH6S3HGU5DvF9GgHHnDH28Z
 bJkcbgnwchbvw/UvPcDoe4LJAfdGN/bPoyoycMpK46PuCirhexHWpYJ5/L4zYOZ4AAAA=
X-Change-ID: 20261112-work-procfs-oldmem-9e80c2ebab7b
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Breno Leitao <leitao@debian.org>, Chris Mason <mason@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Hildenbrand <david@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2874; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sqtljLIH8KoO+/k7KE1Gt/hrphFZnwIFPTrrlrdZ//8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9fR2u/02Pnzf6SneSIY/3/COb93oukuRYOudztZZ0u
 oHTlZwPHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5G8jwP0xmhXO+VVRl/K9S
 y+eKH67dmLyl77jre1aL/4d5T4k1eDIyXFQTW+N5kUUj5zrH27dnf60ybtdbuU7Bn/07Y+aJqU7
 lTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A capture kernel reads the memory of the crashed kernel. That memory
may have uncorrectable errors in it. Which is likely also what murdered
the first kernel.

On x86 a machine check in the copy that /proc/vmcore does out of an old
page panics the capture kernel. On book3s64 the read() comes up short
and splice() panics. Breno has observed that on a fleet iiuc. The first
kernel dies of a machine check and then there's no vmcore either.

I had the powerpc half of this as a fix in part 1 of the procfs series
because Chris ran into it there. Breno pointed out that x86 has the same
hole.

I think that likely makes this a kdump problem and not a procfs problem.
So I moved this out together with the ioremap_cache() fix.

The first two patches make powerpc's and sh's copy_oldmem_page() check
whether mapping the old page worked.

Every architecture that maps a page of the old kernel copies it out with
copy_to_iter(). The third patch puts that copy into a new
copy_oldmem_to_iter() helper. It's just copy_to_iter() with
_copy_mc_to_iter() underneath.

On x86_64 (and book3s64 - whatever that is) that's the machine check
safe copy and the machine check turns into a short read and -EFAULT.
Everywhere else it's copy_to_iter() under another name.

I then convert the remaining architectures so the copy lives in one
place and any new architecture with ARCH_HAS_COPY_MC later gets this for
free.

I reproduced the x86 panic in a kdump VM by injecting a machine check
into the copy. Without it the capture kernel is gone, with it the read()
fails with EFAULT and the kernel logs the event and keeps going.

The helper is a static inline in crash_dump.h and that pulls uio.h into
it. If people would rather have it out of line it can go into
kernel/crash_core.c, which builds for CRASH_DUMP just like the arch
crash_dump.c files do.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (4):
      powerpc/crash_dump: check ioremap_cache() in copy_oldmem_page()
      sh/crash_dump: check ioremap() in copy_oldmem_page()
      crash_dump: recover from a machine check in copy_oldmem_page()
      crash_dump: use copy_oldmem_to_iter() everywhere

 arch/arm/kernel/crash_dump.c       |  2 +-
 arch/arm64/kernel/crash_dump.c     |  2 +-
 arch/loongarch/kernel/crash_dump.c |  2 +-
 arch/mips/kernel/crash_dump.c      |  2 +-
 arch/powerpc/kernel/crash_dump.c   |  6 ++++--
 arch/riscv/kernel/crash_dump.c     |  2 +-
 arch/sh/kernel/crash_dump.c        |  5 ++++-
 arch/x86/kernel/crash_dump_32.c    |  2 +-
 arch/x86/kernel/crash_dump_64.c    |  2 +-
 include/linux/crash_dump.h         | 22 ++++++++++++++++++++++
 10 files changed, 37 insertions(+), 10 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261112-work-procfs-oldmem-9e80c2ebab7b

