Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583224;
	b=nNmPwZol+uCPOKk2Y9fdi+jwEVgt/mgaUJzuYVShuMIt7RdTa289wsTLiORbG65fnX26
	 GneL+B+YToXjlo9Wfa5yAhoshu4q+nvkkRdwSIG9ZnmcIk/GcHKTM0g6K53vP5/DGKee2
	 mJC89VFAmZg3i0dA7gaNg210dmOvuUByEWy8ugi2zr60oI/418fXqYZ4pTDXiutvb8Dlw
	 MdeWpLq676X6IYBQI4/5qQOhRtJa8UG4bLVJ2uiZOmNaMPws+gRiHv/nl8JRXRfREHFZn
	 r4I5PrgOVaSO3vzD9jOdcB3vgEWq+0CWeOeEJUkFGxrH5GP7he9W19eVE3jg3LA4iog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583224;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=BYBJSPvY2X+KL2BJLgT25RQ+sV06TbNGUVsplrREUjo=;
	b=VHWmRaxn7YRY0v8JuAWut73k0DdMiIHckAVFEdNFlVGNPdZXOe9xxBaq/OpzdG6X6G1W
	 2WgdcwBtasCkG69VVEIx6JbeWZs7kvttIdOIqHjtqd6kZsrH5W/bYUNwJkuByD0oPG1SE
	 1qlZKAYH2GN4b4NRmgO0DCros7CZvax/Mmo95Hr3gUQsKejTg6tX/PFaljrI9cq3ORFoJ
	 mGjjhM7FpcINZvM9VtC5hwaKr/aK9cbqI89w/goVj+CfpJ/BgsM/mdfCj4U9FGkHAAZmT
	 ak3oh+aYgmCewa/0zhgeXfL11MEonK278n+Uz58LewSgOXaP21iSqrpt4UnRG7giOgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y1bhsBmT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC54606A31A;
	Wed, 21 Oct 2026 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y1bhsBmT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDA11F000C5;
	Wed, 21 Oct 2026 11:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583224;
	bh=BYBJSPvY2X+KL2BJLgT25RQ+sV06TbNGUVsplrREUjo=;
	h=From:Subject:Date:To:Cc;
	b=Y1bhsBmT1NwwgjsUshX0rfQfaftV/TZEIyM8KvOTyoxsRAoA/ZBWk0biPYG6LfSeD
	 byzlqUM5CqGy/l3qgcjfVYHyf+qxzaJzQOoqImrn3xG84n9IZpiBBGULghwImbzQU0
	 3I8T/lb4qYUB2dZVP1RJFplVB3usiEh+CYFT587pSRkcBDuTmB5c5/hN2lGSWkLWlS
	 8Z+5eZpxbvq/kZcxWlsaDOkpO9Y86lgeRyk6yccIiMpim9Ka6e1vAH+RlChv7I9AEt
	 BKpFzvenoV1Fhhlm3GspQZFLuJz6qOpSRKiqvx7M66h3qFGytIfe37yiXlGFZDF6pr
	 n64SMu0f0r7ww==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/6] fs: fixes for statmount() short buffers and
 listmount()/listns() cursors
Date: Wed, 21 Oct 2026 13:46:53 +0200
Message-Id: <20261021-work-mount-statmount_listns_fixes-v1-0-8917a4c1bd14@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMWw6DIBBFt2L47jSAxibdStMYwLFOH2AYtE2Me
 y/o35y5955VMEZCFtdqFREXYgo+gzpVwo3GPxCozyy01K2SWsE3xBd8wuwTcDJpv7o3cfLcDfR
 DBllb2cqmv9SNEtkzRdyDrLndD+bZPtGlIi4NaxjBRuPdWF7LwOdjsW1/jmqi5qEAAAA=
X-Change-ID: 20261021-work-mount-statmount_listns_fixes-03b0604d7341
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Miklos Szeredi <mszeredi@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
 shaos <shawnq1@163.com>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2110; i=brauner@kernel.org;
 h=from:subject:message-id; bh=3oijdhCB3aWTj3qJQGgUlAJYEtp2M1MvTuQf8jS0b3o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdWGYc9WGHnO+TcL2uoyeYyzn+7JinPLPb9vsT8+IFy
 1YbLXVY3lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRgEkMfwVtT/mFRrH+djgV
 IHHt78zuYOXn9pWBpW2tO0VMnRq3rmb4n7Xg6BRrzk/KZyXTPdh3ratS6pdr2rvgbrj0580pJSu
 +MgIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

shaos reported two issues in [1] and [2]. Both are real.

- statmount() reserves the empty string in the seq buffer before a
  handler runs but the early return for "nothing emitted" never checks
  that byte against the caller's buffer. So ask for STATMOUNT_MNT_UIDMAP
  on a mount that isn't idmapped with a buffer smaller than struct
  statmount and we write one zero byte past the buffer. It's the
  caller's own memory but that's still not ok. I'm fixing this in
  prepare_kstatmount() where the exact-size check already lives so that
  unset strings keep pointing at an empty string.

- listmount() and listns() add one to the cursor before they look up
  the next entry. With U64_MAX that wraps to zero and the listing starts
  over. No real cursor can ever be U64_MAX so this only bites callers
  that make up cursors but it's still wrong.

All three come with selftests. I've tagged the two cursor fixes for
stable as well since they're trivial but I don't feel strongly about
that.

[1]: https://lore.kernel.org/r/20261020110747.959829-1-shawnq1@163.com
[2]: https://lore.kernel.org/r/20261020110732.959552-1-shawnq1@163.com

---
Christian Brauner (6):
      statmount: don't copy the reserved empty string past the buffer
      selftests/filesystems: check short buffers for statmount() strings
      listmount: don't wrap around with a U64_MAX cursor
      selftests/filesystems: check listmount() with a U64_MAX cursor
      listns: don't wrap around with a U64_MAX cursor
      selftests/namespaces: check listns() with a U64_MAX cursor

 fs/namespace.c                                     |  5 +-
 kernel/nstree.c                                    | 29 ++++------
 .../filesystems/statmount/listmount_test.c         | 11 ++++
 .../filesystems/statmount/statmount_test.c         | 61 +++++++++++++++++++++-
 tools/testing/selftests/namespaces/listns_test.c   | 34 ++++++++++++
 5 files changed, 120 insertions(+), 20 deletions(-)
---
base-commit: 08a7d685fc611140f5d4244abef522b71900c563
change-id: 20261021-work-mount-statmount_listns_fixes-03b0604d7341

