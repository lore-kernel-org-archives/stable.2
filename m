Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795752543;
	b=JbefM6ik2YhdYW6LHeofLdow5/o7hQSAXAhpD2GQhUMLZiWS0s27T39yIdLFZsB1pkFj
	 V2611eddONVWJTAQWE01TzkaqpgsJAr+v4Q/3up/DxC5J8KuBAHAw/u7xxqCokKjbwdpz
	 wtrHcJZDCeEj3cOxfrAy4ICVrC3Kj+rAaG/sN0ST9pWAbPmnPbo7YNedg8gCVZ6mDOYJb
	 TsUx1VnJdDFSazTXBc8u0I3xQu8xuGEe3p8yBC/VPWwl2FzkUCVClknbO7IReFdspygeV
	 LMeuvCEpj7GFz/17wBV0HhiFwGoDGXIKD8xUhjQVcfCTEWEeCVBYa5UAM+yWyDPNt+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795752543;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=li3JX+2Xd1AiqIgciAZ7DZSxkrw+I5jSEeNc/twiSZ4=;
	b=OTOvMCTKpfcnwpwr7FGNu/FFqZGm9wtOaZ45TSgyhsYW9EldRFCpmXwWU+BiHc5sVbbb
	 I3a0jmCfYzXgFmhCc6w4TZbNp1g3o89j24aUTTu6ANQFRdt8I48/vVWr9ho/0PFJWciBu
	 j6EvQjHzFqSDMFPcovpZKeWQfsrKzqFRDOmfQp7SRszibZNPyoPsKd6GNIrINivtKmZr9
	 +VLsnyeW8HaFwoJExrW+BiZxIMPzOIa3bhljnQhgkyZHZmzBoseuRpA/Fk+U2akDwalyy
	 lsIaoExxqWW9szP74askdFe2+V5DX+tqyukEaEbgQpD1vcd606XKM3G7vmkHSbr4xpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+oAXcfJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C164B606A32C;
	Fri, 27 Nov 2026 04:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+oAXcfJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795752543;
	b=r9sfhgD1kvBWHINRmHu/cKNolX5FJFPHaKm+qEvW0worfM5HLRSzrWWYpplEjZBGAF/Y
	 5sKG4luj9IE9jTa9b8P+mHfe3gj/5E65LrS3ODfize9AuPQftDvOMGbc7O04hgOmm9czb
	 AsKnQEbYDjwo6X+QWCnUqTFeEOxiakN1ZosPlKukpOoFt77hbU2BXx+tvRs0ci8JdFSMm
	 FEw2lMYCJvCLfOxDvPyYz3tQeXB9NdfT/Ivv4MDPHvm8gd0XuVqqUsQ5S5zwRrjoNoceE
	 Rm/X6ZFWpg5dxuSDriL6FaRM/qGo5aL9EWcQjQj8VuqWkn2sJYen3JqzVfUXIvaHxRg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795752543;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=li3JX+2Xd1AiqIgciAZ7DZSxkrw+I5jSEeNc/twiSZ4=;
	b=g6TYauPgZucmoBcu5VcKLqHABTF90DekMUy+9074Tl93NHo4Je2rLOJ9gdO9ZyGz+EtH
	 iPVLHQQplw0kBMMW8BVlam5Qgmpta/QCpkK25GIgoogtQAIF6HEhuVl3qvhKypGkO/T2v
	 PPMYyrQkhDW9XuQ08/2tp40hELxZsLsvypyvad0PO5c/JpY+9JE2g92BNdTx3/EvsgeNY
	 xFNW35BT/RWUkHmFQPrsisTX92Uu411cST4aVQsmhEycDzzt1vQx4a/McJhoQmqSr7KSm
	 Z75Y3AzmuWeOnq3IZwisqnE7BmFCqMPJY9jtXP9w/JEaonMi8R6wIh1sOqMfCJmM/5Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 31CCA1F00923;
	Fri, 27 Nov 2026 04:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795752543;
	bh=li3JX+2Xd1AiqIgciAZ7DZSxkrw+I5jSEeNc/twiSZ4=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=M+oAXcfJyMhh4ui+uVN8NR+BdjjT58rZZY7NQ2xfin9m+84o46Od/4UsOV6t96hl/
	 eMiYz8j3l3XzWMPp0XUsKAw7i3bF0RRi28/cgsRZMjW1BgNKF1CDCJnXDL+Ikv8+jB
	 zsiiVC/cI+pyTOlH9KWj9mYOs3ba2M3ZudzUqEp7Q/I9F1uJ48d/acGxX2JcRl0jRC
	 NTKc61WtG7BE3fHaV06+UrmB1IJRSuArcA/7311BmYelG5nT69Gh3y8LumagW7hvXO
	 rqus8Z4YL/5XTgL6t4SIRgJnsj0v2MbFAZvzcXrkR41s+ciABXFmvdAezctLcvMIP+
	 fY5UzPxTl+m+g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AA5484B55B;
	Fri, 27 Nov 2026 04:08:51 +0000 (UTC)
From: David Crawshaw via B4 Relay <devnull+david.exe.dev@kernel.org>
Subject: [PATCH 0/2] fuse: fix data loss when writeback races a
 write-through extending write
Date: Fri, 27 Nov 2026 04:08:38 +0000
Message-Id: <20261127-b4-fuse-wt-eof-v1-0-e055e2af652d@exe.dev>
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
X-B4-Tracking: v=1; b=H4sIAEYCCWsC/yXMQQ6CMBBG4auQWTuJrdiKVzEuKP7VcQGkA2rSc
 HcKLr/Fe5kUSaB0rTIlfERl6AvMoaLu1fZPsDyKyR6tM8Z6DjXHWcHfiTFE9sGb2jWX8ymASjQ
 mRPntw9v9b53DG920XWhZVk8a8N1yAAAA
X-Change-ID: 20261127-b4-fuse-wt-eof-7b71469853be
To: Miklos Szeredi <miklos@szeredi.hu>, 
 "Darrick J. Wong" <djwong@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Joanne Koong <joannelkoong@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: fuse-devel@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev, 
 David Crawshaw <david@exe.dev>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795752531; l=1976;
 i=david@exe.dev; s=20261127; h=from:subject:message-id;
 bh=/uZwlpKJlvGvr6lTGIgh3p40tIbnOtPhD5Kl6WqbtuQ=;
 b=+7IrrOKCwsFl/f8JAosPywwOryhD5UclQsoKBCSUXZ4rKvgiQraL0C6ykQ4RX58RHmueH3z8e
 CqpLN5xraBTDsm+mvL5eAd+qJQdgfKBO6yqS8Mttj0rhY8y52FW3FR8
X-Developer-Key: i=david@exe.dev; a=ed25519;
 pk=eQfKiR9S2peqiHuuNGCAaWlxwP+RerhKT2wVxakCrjQ=
X-Endpoint-Received: by B4 Relay for david@exe.dev/20261127 with
 auth_id=1661
X-Original-From: David Crawshaw <david@exe.dev>
Reply-To: david@exe.dev

Since v6.17 commit ef7e7cbb323f "fuse: use iomap for writeback",
a write-through pwrite() that extends a file inside the folio
holding EOF can return success and lose its data. This happens
when that folio is dirty and writeback of it starts while the
FUSE_WRITE is in flight.

The mechanism is that fuse_perform_write() unlocks the folio before
sending the request and only updates i_size after the reply, and
iomap_writeback_handle_eof() zeroes the folio beyond the old i_size.

Patch 1 keeps a folio that straddles i_size locked over the request
when the write extends the file within it, and updates i_size before
the folios are unlocked, like iomap_write_iter() does.

Patch 2 adds a deterministic selftest case.

Reproduced on v6.17 and v7.4-rc4+ (9437ee8b6cf9); not on v6.16.

Data lost in the reproducer:

                                   unpatched        patched
  WRITE delayed 200us/0/2ms        1428/1500        0/6000
  8 mounts in parallel             3229/4000        0/4000
  EOF in a large folio (THP)        811/900         0/900
  new selftest case                 50/50 fail      50/50 pass

(All testing done on x86_64 KVM guests.)

Disclosure: the bisection, and both patches were produced by an AI
coding agent (exe.dev's Shelley, using the Opus 5.5 model).
I reviewed the work and wrote the bulk of the prose.

Signed-off-by: David Crawshaw <david@exe.dev>
---
David Crawshaw (2):
      fuse: update i_size before unlocking the EOF folio in write-through writes
      selftests/fuse: test a write extending the file beside writeback of the EOF page

 fs/fuse/file.c                                     | 21 ++++++-
 .../filesystems/fuse/write_extend_eof_test.c       | 71 ++++++++++++++++++++++
 2 files changed, 91 insertions(+), 1 deletion(-)
---
base-commit: 9437ee8b6cf607e883b36e44bd755968daaebd48
change-id: 20261127-b4-fuse-wt-eof-7b71469853be

Best regards,
--  
David Crawshaw <david@exe.dev>


