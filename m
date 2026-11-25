Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613204;
	b=yy8dg58OwfOUAJcuBD0QaOkJKjRTVvgjUpHq/bb7d5HVrCOTv8+k8uJCLLSbZ9c/exVR
	 rO8swdXpFS058VQAAXxf3FZW7OE0qIYpYrdlEklbpHNwMwaBi+Uplq2/9eZvHOWGY5EVc
	 SOY49B3Tyw+62g+SSOomkMvwWlWdCXduQRqW7SDSYWv/0SVQ0jfDcsWfk3w0xAFI62+VT
	 yO91UY9BTs4G2Vah/ltPG6gRnhyW1LxhFexEngP6jccGJMgRNvj/IkwYiwYttPvCmjUqL
	 fUgx8GEVuD2mVhGJs+qK1zyntcKTmAxDoi0ImCZCdMO99Zps8TJ3DA6vnBhGP0k7/dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613204;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uM7VqOkMljiRrkOde+VoeTeZSpb+jARpg0aFOyEVz/E=;
	b=BeFjrrjaP1vm8LE6yz/mZjtDSi2Oa2qnwLF2mkDEA6rzIecwHijjjqdSvnMTqtJJmKrm
	 hnZeGs0i80r68pvymCxpmjsZ1CG3LfIQEPsBGsAXWVyvDyRPi+jFLm+C/9bIF9lYL/1Km
	 Y1D2Itnsmvx2oKNoMgvm+sxTd2Ps7mEHlQZ8v1Jktcx8qFNFnvUOSAmsobSgw46VLqS8P
	 COlbhjtGRQyBoK58bUmnC8jwkC9sEeDWO/pfNhDZqqr5iNcNFSP0X3dkEvQOlWUCrn7B2
	 0Qpw5cPaSEaxOfil8v9ci3MTf6juNCXw1CGpE7KE779w2g6F4o75DWZOz+ZcI/PbBIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IntcI1Zl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA0E606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IntcI1Zl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272A11F000C0;
	Wed, 25 Nov 2026 13:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795613203;
	bh=uM7VqOkMljiRrkOde+VoeTeZSpb+jARpg0aFOyEVz/E=;
	h=From:To:Cc:Subject:Date;
	b=IntcI1Zl8QF7BHbYc5eDBgSFNBskEBAzGPdQ4QMRWX2ZogbsQXHgpOT65aKw3dERl
	 RKQeHXuLxAqCEfX+bitLV1rlCN3YlskodZGHxZ1H7YQD1dD3fXICGeUMp/aFFB5bzO
	 ovuM1NSNXrdUZkQHOBFoBrE3scUiZl/P8wQxjo3q4oHiY7A4dWT/845T0RZY+TjcBc
	 yLfx4tHqCsURNx/boOZYsrlOoiSiyYK+YXJEtcPsP6RP82qW904/DrlDJsecgc3R/M
	 M4qmvAviVX/Ocy1ZVaji+MPopZNeDZIJNXnPVTBmEcoW8ZHZYooZkXcJzoYd095YWh
	 3ii+97zqozqsQ==
From: cem@kernel.org
To: cem@kernel.org
Cc: linux-xfs@vger.kernek.org,
	hch@lst.de,
	sandeen@sandeen.net,
	dgc@kernel.org,
	aalbersh@kernel.org,
	bfoster@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH 0/2] xfs: force all shared extent swap to use rmap shared path
Date: Wed, 25 Nov 2026 14:26:27 +0100
Message-ID: <20261125132634.113144-1-cem@kernel.org>
X-Mailer: git-send-email 2.56.1
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

From: Carlos Maiolino <cem@kernel.org>

This series fix an issue while swapping a shared extent between two
files.

The first patch moves a trace point earlier in xfs_rmap, where it proved
to be more useful at least while tracking this bug.

The second patch is the fix itself

Carlos Maiolino (2):
  xfs: move _right_neighbor_result trace before erroring out
  xfs: force all shared extent swap to use rmap shared path

 fs/xfs/libxfs/xfs_rmap.c | 10 ++++++----
 fs/xfs/xfs_bmap_util.c   | 29 ++++++++---------------------
 2 files changed, 14 insertions(+), 25 deletions(-)

-- 
2.56.1

