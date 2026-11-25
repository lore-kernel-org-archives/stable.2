Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602432;
	b=pRFjnsFTqmvR124gxtBYVANLu1GOsLE9zPtRMAVWOvmVmxjsU5ko85eXFWXXM/HzZcOl
	 +B5sykJZZARS8gdKym8L4jEPqxkVZkWyRLjhO0Mp91Yo28e7FeFJY2gOcPaEvDvOA53nn
	 +pQM/5gtbmRD8DBF61a/rL5+/nIvTmCgER2r7qxloivPoxEb2jcpM3LTasqf4YoLvCV7a
	 WVUY+cqbNUMSV4+Ij8g7kPHsCr+dcKDzjJ+zId4b47PE7ObMqAhJAlmpQVM6zuqQpPVWV
	 s4dYoVz84FWHr+dsKkWQdMuUjRITUUgaU9Um1nbXccawc1XCxqTDM27SuWc/ki0HuFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602432;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=CXKo1jruSQjhW8nYdBo4FFAzkVjdofHYeQq37LEsvbg=;
	b=q5f7jf9Qm7amyhYK6GZ/t1FQSO3DU7xrXf5+Bw0YNkdw+TcilfsAcVRpgB5pqB0VN/YX
	 MbFOA6csHVNSRSRoRvVgz011deanHLPml9FFkEhITrAzKClyT77IAj38jYK55XNE4HkCf
	 D+WgwOFU6kO6sXAMV1tX05TNR2KMvngAopl+JwTnShJN7GIU7vvPUrGGBbJ2l3QBHltL6
	 wZFdepf3OD0ZPxdpXYj3yqyuaQD3EMgpJPl3TjoXLnN//Wnxi2QIJQ8mRQRKkDcAnuuRj
	 MeYcCS9eOojxvgI6pxcNSQ84pBp2M4HV6+nzQGDN7KOO82BdMF6kMSmNryfsVcEJSaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m4JWl6Mh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A200C606A31E;
	Wed, 25 Nov 2026 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m4JWl6Mh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAE21F000C0;
	Wed, 25 Nov 2026 10:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795602432;
	bh=CXKo1jruSQjhW8nYdBo4FFAzkVjdofHYeQq37LEsvbg=;
	h=From:Subject:Date:To:Cc;
	b=m4JWl6MheOSUVsvey7mpFcy72qMYNLIzFhV3wkKnv4XkLUf2UuzRl3uKMFMWF+0+d
	 5UG3a3MXzRIiPs5Vb1RHdRrP4UIjByd/7E6W1zO8+CnlzL3uB27V4mTZZNJLi0cm5t
	 IFS6BfHgV7rH7xIliFSo/7SCCmor/0I7F7g/6DiOdZfr0cQdbpOqLOe88K5LRiU1AX
	 N6VG3xAN6EjVUaZjcJRteavXkbsxOO4jJftwiSdYd1JWOdSyJaoGzNGcyoQ7ArtXRf
	 tY9gM0uUYnFjOxF0n4ZGR0LeE7WOMQ0CvGtj0GgqKek7/6ZntjDObx+qtx6sK2b+FV
	 tdrge+Mcz9+5Q==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] fuse: fix readdir with long names
Date: Wed, 25 Nov 2026 11:26:51 +0100
Message-Id: <20261125-work-fuse-readdir-v1-0-44312add01a8@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2MSw7CMAwFr1J5TaIkLSy4CmKRj0MNUoocCkhV7
 964sJynN7NARSascO4WYHxTpak0sIcO4ujLDRWlxuCMO1nrBvWZ+KHyXFEx+pSIlcmY+myOfug
 NNO/JmOm7Ny/XH9c53DG+JCSP4Jse2Jc4yiRJLUn9T2o5wLpuUS4vW54AAAA=
X-Change-ID: 20261124-work-fuse-readdir-0fed3f05a430
To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: fuse-devel@lists.linux.dev, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=2538; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cNE1veV3S+QT5nA9HmRYzHy8uo+p4/7IAskfT0so4RY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSzbf/+6uNVB6ud0+7YVS3VrDRqvHfpxXKHhk3X808df
 thQanhjc0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEWuYw/LMseh2+xz3qy6G0
 06GXpW5s6p+T4pw8pebVb4e2G6nrpjQy/OGqOlsrKXbDT+/rjf0fowVOifI8yhZ8W8X3K/7lxaU
 Vj/kA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This fixes directory listings on fuse silently ending right before a
long name.

Since FUSE_NAME_MAX was raised to PATH_MAX - 1 a READDIR entry can be up
to 4120 bytes and a READDIRPLUS entry up to 4248 bytes. But the READDIR
request is only as large as the getdents() buffer and never smaller than
a page. The server can't send more than we asked for so it sends
nothing. And an empty reply means end of directory. So getdents()
returns 0 and the long name and everything after it are gone. Userspace
never gets the EINVAL that would tell it to retry with a larger buffer.

That hits getdents() with a buffer of a page or less, the old readdir()
system call, and in-kernel callers like nfsd that don't pass a size. And
since we fall back to whatever alloc_pages_bulk() hands us it can hit
glibc's 32k buffer under memory pressure as well. Falling back to a
shorter read is fine (cf. [1]) but it must still fit the largest entry.

This came up with a userspace directory walker that starts with a small
getdents() buffer and doubles it on EINVAL.

The first patch makes the request large enough for the largest entry
the server may send and makes sure we always have the pages for it. The
second patch adds a selftest. It fails on v7.4-rc1 and passes with the
fix. I also reproduced all of it in a VM on v7.4-rc1, including the
memory pressure case.

The request is sized by fc->name_max, not FUSE_NAME_MAX, as that's what
the connection negotiated. But parse_dirfile() and parse_dirplusfile()
accept names up to FUSE_NAME_MAX no matter what was negotiated. So a
server that doesn't negotiate FUSE_MAX_PAGES and returns long names
anyway still loses them. I don't think that's worth caring about but I'm
happy to size by FUSE_NAME_MAX instead.

[1]: https://lore.kernel.org/CAJfpegtcsWnXh-uDh1Qu83dFF9nJji1gytk2y9Wk5p9+JDTZ+w@mail.gmail.com

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (2):
      fuse: make readdir requests big enough for the largest dirent
      selftests/fuse: test listing directories with long names

 fs/fuse/readdir.c                                  |  22 ++-
 .../testing/selftests/filesystems/fuse/.gitignore  |   1 +
 tools/testing/selftests/filesystems/fuse/Makefile  |   2 +
 .../filesystems/fuse/fuse_readdir_long_name_test.c | 197 +++++++++++++++++++++
 4 files changed, 215 insertions(+), 7 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261124-work-fuse-readdir-0fed3f05a430

