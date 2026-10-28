Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793196718;
	b=AvQviCCttp6SP+JJEG77I0YGuwX1K2RIHFjiu4my7AhQW15eRMNQCGJo4sH+msp9CGOv
	 um/H4UdYnSWZObAT2ui+ggZ3STAoFP4OuR23Y+kNTA6xj2dz9tiCXIysCNXIfQoBeEcTU
	 A0YYltadQkHmoRBvx2CxANWj9BUY30hG/EaZlaeXk8Krlsp/1j7EdEkGuspxIRTVkq6m0
	 b4V1aLIkqbQacGvkM3ELvD62TTQBGIxfZKvXGRGzeiexZjDjfaIyQdrgcRf4WY3aLRl8Q
	 2PtNOC4GPAbyX7gqhnK2strrR1AUWEGkMrVr4Jwe7Ggx9+qwKfxvPBbIMsIw+QKb5Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196718;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Aj6NKlEI/katth2wIESymczEJETsapNVp1gfTJSIOI4=;
	b=n8SQAD+cdtqeEkxN1wtvWk3AtvukWXI2IpN+sDNhiS368xaxEFD36+RxD3tXPKD3eHZh
	 Q1afVtqnEA8orCDXTgdWi+3y8jlpJOqrSt+LWzTapGcdX5xZkByz4Zobv9ArNuEnVHsNx
	 NF/dlY7yW5lTznrbRULXdYlWhMbxui1RgMBOaGIf6sw94PAHPVLpeQv9ASowldVYMxKLD
	 2HFln5o/GdW6/rGlMqX+0as7vJeoWlg3QJaxzULt9ggq3TxcsBAV41c2jaEd+gVAXxWRI
	 JFKyhRYkblF4jqmuSMMW8j+DClq3b0RhY3pZaGzDskkCjJn2jLb6prMrvq8WGFHYieA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggbZR6Ok;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C732606A323;
	Wed, 28 Oct 2026 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggbZR6Ok
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2371F01829;
	Wed, 28 Oct 2026 14:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793196717;
	bh=Aj6NKlEI/katth2wIESymczEJETsapNVp1gfTJSIOI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ggbZR6Ok/naZyBXDs/7zovL9VXOUbN2ItXbN3g+z++nLTPY4u2+ZTFAsyfMKR7amD
	 vSZk620hsvA2AVSmX5WnHEo9iF0bReERm8m3chFlU5YJhnSPuoiMsnZeVkO6nm/pqx
	 IRgzNKHGWbDrqiNPg9TlENI1G2Pmi+8ZKHZ930hLdiTtBze4VYDp2p8HVHz0nREz4A
	 mvoJLBlUkdanhnG63CXapTPmfhpkbY1dTtTmnF7TC5c9bA2m/qHZpR39jOh9k6w/IK
	 h8/SHHEiYMtoe/a+wRbcpDxANKc+mo3zg//FjvrhF4oquLROvBZ2MxS3RCq8tnQnif
	 I2TdLbCQdxJgA==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6.12.y 1/2] mm/damon/sysfs: put target pids for damon_start() failure
Date: Wed, 28 Oct 2026 07:11:48 -0700
Message-ID: <20261028141150.160711-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028141150.160711-1-sj@kernel.org>
References: <20261028141150.160711-1-sj@kernel.org>
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

damon_sysfs_turn_damon_on() allocates and sets up damon_ctx to start.
If it is for virtual address space monitoring, the setup increases the
reference counts of the target pids.  After the setup, the function
invokes damon_start().  If damon_start() fails, it deallocates the
damon_ctx object without decreasing the reference counts of target pids.
As a result, pids can be leaked.

Fix the leak by putting pids using damon_sysfs_destroy_targets() before
deallocating the damon_ctx object.

Fixes: a61ea561c871 ("mm/damon/sysfs: link DAMON for virtual address spaces monitoring")
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 5aa23c6545cb8..107a28557afe2 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1519,6 +1519,7 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 		return PTR_ERR(ctx);
 	err = damon_start(&ctx, 1, false);
 	if (err) {
+		damon_sysfs_destroy_targets(ctx);
 		damon_destroy_ctx(ctx);
 		return err;
 	}
-- 
2.47.3
