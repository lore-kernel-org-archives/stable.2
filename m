Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795693272;
	b=1oyyz9fJyUZcnfAC3VQ2+DDr1w/YWiL4ZduKIDbL2ktjwiya5APutWVj5c2B+tXOy6pz
	 er0hVKJNcI3DFxusKELqFviZLsnhxjbzDzYDFIWPVDjv1dfZQmbNoCqFtMb6Om3g7gtXG
	 bSKWL8CkXHQKhFu3XoPnDhT3t5VGmak4CjXG9agIpDPJnJcmwm4ve2MSaXSCy216bxmJi
	 QSSygwYasMFSenfMYTSv4IVvBIUqjtP5n4iacDlpjXbCpbT4ItvBAgBJoig6QlVUnyVTC
	 AIfgflPAvfY4vKcYVH4EYHbMy+vhUeARQJklMIA/W81C+o9NU6CuSRj4f2iW0g9g4cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693272;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=FP9pt3QilAIpGn3f/dJzkmExKoiwGWGGll2pCN+MFX0=;
	b=Z0HBZisGQLYhf5AwhZgQD9qWQq/+3KWGgBzGevDV3oyJb0BKZA1A4+RbdYY/kmG0hNGo
	 GdD5gySUzmlP3E8FFxKE5jVHIUujuhzXXgfhiT15BOVgLthdPoS5t6e6zLP3rBbppudMG
	 r5OPq4o3+lMmgm8sg/LFJeV+3UenKO8l/Lgxm8pVEGimOEmo6YyTPTk8qb6XXdUiQZzMf
	 I1pYoHcjCVrIHMIK+H2JNojF3UV6achBWC4QeHNtEOHYlHwY2+UneF/1ex8GLSH5IdDVj
	 hOuwIY0HJdftS9i0Us/bZYAJAnt2d0aTeWN8yAEEuln77X7ffD+jeJYKAUbe9UF6pkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TN71n9ol;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4D1606A32E;
	Thu, 26 Nov 2026 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TN71n9ol
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AFA1F000CA;
	Thu, 26 Nov 2026 11:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795693271;
	bh=FP9pt3QilAIpGn3f/dJzkmExKoiwGWGGll2pCN+MFX0=;
	h=From:Subject:Date:To:Cc;
	b=TN71n9olPeXZGQwicPObHATxfmwrRXlFDUF1baVhc5froBsm8oxJs15colF9p+byb
	 Qc0sHvyT1+cVz6id5CEymCR/lGjZf9mqQUghCsZXcURUqLOcnBKvC2QWpj+NuBLnJ6
	 Tvd+64/ytHIZ8cYGX5wCRL5j08D1NfKKVEH/kI/dX2Iqb++s/gqXlKMciUlG+Z2BwB
	 xaiHU5hpwMFMp5UM4rxZU1XTXcHqV1OKDCP148HbuP+EqSlAEkdg0/rPRFBMRITHv8
	 7LN66kQzw4sFHkdtXIH4PunHyH49SWkWbjYemWkUamgHLeYH2Lh4XCECeDk1fUPp8W
	 /PvgsmaF1km0w==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] namespace: allow bind mounts of ephemeral procfs files
 again
Date: Thu, 26 Nov 2026 12:40:32 +0100
Message-Id: <20261126-work-mount-cant_mount-v1-0-781d911a32e1@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0WM2wrCMBBEf6XssxuaUOvlV0Qkl9VGMZFNqkLpv
 5u0D77NGWbOBInYU4JjMwHT2ycfQwG5acAOOtwIvSsMqlW9lGqLn8gPfMYxZLQ65Msae7frOiP
 3+uBaKN8X09V/F+/pvHIazZ1srrK6MDoRGtbBDrWqWrG4xF8r6gjm+QcLwMMPpgAAAA==
X-Change-ID: 20261125-work-mount-cant_mount-6d744b18a9d0
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Aleksa Sarai <cyphar@cyphar.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=1620; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0xppqihwRu8FodWUm5W9j6NaRYtJt/bVoAcwbOmE7EQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRzSF1Y29tzxYDXISo94sljhX6ukNnZWXMbvRJi9kw7e
 +1m1/ncjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkEMzD8L9UO1066ENJ4Uein
 jfQCdpVlHHmejpdmG/1Rn3suJoArn+GvtIT2T5/J1iXGYR85l86ReMLBonBgSbD08qqkBz8Yj2c
 wAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Bind-mounting of files in /proc/<pid>/{fd,fdinfo,map_files} and below
/proc/<pid>/net got broken with commit 75f4197f1e11 ("dcache: don't put
a mountpoint on a dentry that's being removed").

procfs calls dont_mount() on these files so nothing can be mounted on
top of them. But attach_recursive_mnt() makes a mountpoint out of the
root of every source in case it goes beneath a mount. So bind-mounting
one of them fails with ENOENT now. libpathrs does exactly that in its
tests and it's broken in stable too.

Only refuse such a root when the source or one of its copies would go
beneath a mount. The race the original commit closed stays closed. The
selftest checks that these files can be bind-mounted but still can't be
mounted on.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (2):
      namespace: allow bind mounts of ephemeral procfs files again
      selftests/filesystems: check that ephemeral procfs files can be bind-mounted

 fs/dcache.c                                        |   5 +-
 fs/namespace.c                                     |  25 ++
 fs/pnode.c                                         |   6 +
 fs/pnode.h                                         |   2 +
 .../selftests/filesystems/mount_cycle/.gitignore   |   1 +
 .../selftests/filesystems/mount_cycle/Makefile     |   2 +-
 .../filesystems/mount_cycle/procfs_source_test.c   | 283 +++++++++++++++++++++
 7 files changed, 320 insertions(+), 4 deletions(-)
---
base-commit: 2dc60bd9975fc8666a13d58410499e06e6799ba9
change-id: 20261125-work-mount-cant_mount-6d744b18a9d0

