Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094724;
	b=wiI8Zw2WHJzYDEey/sFcSSl+Qb+I3invfp1fkwUNE146NEjoYZHGBRx6UsKTL5VMT9Gg
	 aKGaptWgkZODqrNiEpn72HzLnPCTelnOwC/yinTKQfM/fLht5Tzp/ipIPDZz6t7CfDaql
	 CEz5+m2xa55PNFLs4yQD2dFgVcgLaNrQzflYjNyhp8pqhK7HVV/ZXLjYtJDvg6IM2MS4Q
	 MC07kbAFg64rF3CRVzta7rSBUdzYauoiDW7WjOjFGkQtL4MuA9KW6Cg1ezJKLgpmO7lsQ
	 GAE1mToxNme5SrbWvm8NPutxcrGiDz4IETx2iExC8+haKobkDhovFCGH97tA+nXZ4rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094724;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ofAK+TtSrgxFn0fqbnwYIkMb3kIrTnuDvIlgjdaqZDg=;
	b=FOlDWpiGXLZ+x/8OWO8uBHlTyNhmYguzg04rPZEBZSNDsp07l4RcYO/JlQcmNZlHOAOF
	 P8Xfraxy/JXZKZkHfhGMhTJlTWnR6JtuF/ay9T/ty57fbWSUi2SGyYG4lMDe4nwRIKGPA
	 X3QdnSRRcTaRAvwk+OMCxaYj++J8971C4gnzyHL1gEWLdLW7ndtBLNrzKk4wUPB/V5xsK
	 XR6aVpaknsFy7EjwxQKjqNRO4+JdhjX+Ad8eDTz6XzFVrF1rrnnxQU9dGRvK+jYuhYCwP
	 2tSEm4VtrdTxulXrtYkB0JJop7D+PpRvOQGyfgmoI906Fx7sEaLQH3QbvHO8BTLtRsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CbjS7iOt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4450A60A2615;
	Thu, 19 Nov 2026 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CbjS7iOt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3638A1F000C5;
	Thu, 19 Nov 2026 13:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795094723;
	bh=ofAK+TtSrgxFn0fqbnwYIkMb3kIrTnuDvIlgjdaqZDg=;
	h=From:Subject:Date:To:Cc;
	b=CbjS7iOtaQgqeNHFlWRyuhWl0BYY8tj5K/k6hO9igy0LZ5tqxK1SsnC3gYrYWtmbV
	 YmgXzBc1ArNLestDZaDYEwSP1piCv+ihxhHbSPN6ahS8V7XZLKF8qtuOiTVASihVzD
	 TncJoEZYQ8038Q0PdGFWJ4+tVrgTwxGT/C5mizLEpoEkmZ/E/mg2RHoXC4iLtK4K9u
	 raDdHAKSMDipOZf7ToNUNAw1HXny/Pya1xeUSPpqJIqzw31KfnZ/NG5MW5AQhTtSFE
	 ZU+qw0qKiYBYtVUL6cO5vucUFtWX62gZwwel37pOkwELUSraVUtsy4GYPyQRpKK8Bl
	 gtvsQ9XcDCcyg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] fs: don't reset userspace_init_fs when PID 1 stops
 sharing it
Date: Thu, 19 Nov 2026 14:25:00 +0100
Message-Id: <20261119-work-fs-pid1_unshare-v1-0-b6a7e468bd68@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMUQrCMBAFr1L226AbpVCvIiKbZGOjNC27jQqld
 zfVz3m8mQWUJbHCuVlA+JU0jbkC7hrwPeU7mxQqgz3YFhE78x7laaKaKQW8law9CZvu1MZjjDY
 gOajqJBzT55e9XP+sxT3Yz1trezhSNk4o+36byqSzMA37gXRmgXX9AkJGJHmaAAAA
X-Change-ID: 20261119-work-fs-pid1_unshare-946f3ff2d1ab
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Akisaira <akisaira@outlook.com>, linux-kernel@vger.kernel.org, 
 regressions@lists.linux.dev, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=1979; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4gRVFzcDkluO14flBMXFmx+qNRCqm/N7ycOY3paxx60=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9+7FHVeaw+4eX8S8Y2vc0bjV4cC3+XnrWDpHEG1sTn
 zAyWfoKd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExE8z3DX4GsJ6t/l7n0x7HM
 t3sZ+fAb10uDKxwFXN5xaYnp5seK6xj+Zz1K2uH2sr6g50XPhJ1vbPxFzz6bYRb0L3FtpV1Xc6I
 pPwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

In Android's second stage init StartPropertyService() spawns two
threads. They share PID 1's fs_struct via CLONE_FS. So they share
userspace_init_fs. Afterwards SetupMountNamespaces() calls
unshare(CLONE_NEWNS) on the main thread to create a second mount
namespace and setns()s right back into the initial mount namespace.
unshare(CLONE_NEWNS) implies CLONE_FS so PID 1 switches to a private
copy of its fs_struct.

Ever since v7.3 validate_fs_switch() notices that PID 1 stopped sharing
userspace_init_fs and resets root and pwd of userspace_init_fs to
nullfs. But it does that in place and the two property service threads
still use userspace_init_fs. So they suddenly find themselves in nullfs,
libselinux can't open /sys/fs/selinux/access anymore, every property
write is denied and init stalls.

Before commit 14adbd5341aa ("fs: stop sharing fs_struct between
init_task and pid 1") PID 1 shared init_fs with init_task. So
userspace_init_fs was init_fs and the reset was a no-op as the first
stage chroot had already updated init_fs.root.

There are a couple of fixes to not leave stale state behind but it seems
that there is legitimate userspace out there that does need this. So
stop resetting userspace_init_fs for now. I can probably rework this to
something sane but I'm not sure it's worth it. Kthreads and
usermodehelpers keep using what PID 1 left behind, just like they kept
using init_fs before PID 1 got its own fs_struct. Keep the notice
though.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (2):
      fs: let pivot_root() move userspace_init_fs when nobody shares it
      fs: don't reset userspace_init_fs when PID 1 stops sharing it

 fs/fs_struct.c | 72 ++++++++++++++++++++++++----------------------------------
 1 file changed, 30 insertions(+), 42 deletions(-)
---
base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
change-id: 20261119-work-fs-pid1_unshare-946f3ff2d1ab

