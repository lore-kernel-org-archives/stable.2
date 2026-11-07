Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794080726;
	b=qIF17dr9YvK0c3FaOu56dXbv9ZYUs3MlSjv32XdXd1J1XyzHuXBodLThxq3aqPFKoR80
	 lf6kWTuIQxyCcdJYjFaVq+xTW6PdrwovnJPJs47CD26p2osQInws8t8BzfngjVTiT+4P6
	 qqcaK/y3pTAAfa4l4zWBvDPq4TbBUoEkwc0T1yjyHHIU11SRrC6HGFc8Uly/fNwKkNTaT
	 bqXZmgrKX8tJpINTQuk8PNvucHHP7uAr44bnc+CtATgDVPcN9kMvl8EKZxQhdIoKiOm0V
	 Plg+zrB+LLDYufOVIDA+wy95f0nBSp+kNcfOV3YAQjR0KZPEQf6eLUFp8frJcJ9kqLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080726;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=o5HZFJzaeur4LfIL0/2xLw6i1fpPohSAldN75CSZURs=;
	b=B9cOidjPlJ79EGg8DX/WGGa2jczUX6hr2DQEId5JjbUWh5FeGbmCkpmoctRIaA3VjSWA
	 d4oKS1ZpPs9s/JGJ3lqKinPRSBbYeXczCTQLGJfS1c9vIrh+mRnO4KL1vcOP43SmK9DA0
	 httFTyOTcqDjt7chvwK0bbytxCejlVTNEmo+b+ZnoL3oDj9t47Q/p7FKHYMZ+FpQYaGOh
	 Zc7BerDcZ5pn2qcjC5lpz+RKUDVM7doPo8suMID6k0cQO+1zaFjUW5zXycVhVmEnpLAFQ
	 cmoOkQ0vAOVNaA1UC1boVyafg/BxXhu4Hc9PdNUwyuAeoUceWwIWNhq79g02CRaDCEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ckDl5lfn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B19606A326;
	Sat,  7 Nov 2026 19:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ckDl5lfn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CF01F0089F;
	Sat,  7 Nov 2026 19:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794080726;
	bh=o5HZFJzaeur4LfIL0/2xLw6i1fpPohSAldN75CSZURs=;
	h=From:To:Cc:Subject:Date;
	b=ckDl5lfnJF8INRAig4TULdkctRX7x63jq49s74OiVwnhPm56WxS6rKnaB5c9qbr0w
	 Irkx7b+H+MiCz+BvXfxhDA24amUsbzLnpeNLAbaevu5KxetLi9gAZfm7V1a8nvPYRY
	 sDgRfFL3XGmNBXxgDXk32pWd0++OPX3K6Rtz4Z0y7u/S95+PqRNyyrq7HL8wZE9v46
	 /gQkQh/G/dj7qHiHJL7d5vxg8zIAFc2YSzRxzzOhxXcDmEeMXbzaJ91qLtbFqN9hRG
	 eo790II///65uL3wqoHwRDGkFOdYl6zjkTcBPAVfG0dWHnhek5N4+gAnmcm544fohV
	 PSsK/S88ggNxw==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: fsverity@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 5.10 0/2] Backport additional ->get_verity_descriptor() checks
Date: Sat,  7 Nov 2026 11:44:43 -0800
Message-ID: <20261107194445.55959-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Backport "fsverity: Be more careful with return value of
->get_verity_descriptor()" to 5.10.  Easist way to do it was to backport
"fs-verity: factor out fsverity_get_descriptor()" first.  Both are clean
cherry-picks.

Eric Biggers (2):
  fs-verity: factor out fsverity_get_descriptor()
  fsverity: Be more careful with return value of ->get_verity_descriptor()

 fs/verity/fsverity_private.h |   7 +-
 fs/verity/open.c             | 148 ++++++++++++++++++++++-------------
 2 files changed, 100 insertions(+), 55 deletions(-)


base-commit: 3a323bc22b881a5bdc1646080f93f5ecb22850bf
-- 
2.56.0

