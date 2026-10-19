Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792433876;
	b=0qeMo4Qh0+HOx5Xdyfkopkbs78gZq6uQtjuFpp0Gm5YBGDmEIJ7cw68SHsRZgKgKPpf9
	 NW2R8fCUUp6G5l//N/MHAkceBptxCUHIYhQRno0gnS3jhMGOGFtk9Yr9KqyWTEdm6vW/Z
	 DlniCX+MgsaAm63be2ScODLpZt+piSfMPwKN9CZEAx45OXqT/0sR5irudlIBLHvEtMm4L
	 eQ9y7WRp5+1t3L+464z0I/S+5bWOMIf4gxJxZhPmt5fyft7agF0CuIFlFqBXuZmaMyd1g
	 FK4E7ZXtKtPl4f6YVnCij2Arq1Sok9qoNEeaFzbVzqUM3gJMr+tvduJY9Z5U3NmbBSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433876;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TxT5MkEpHy2GUxsA9o7iiZv/Vrk1zXGXHdpML8q2bwU=;
	b=uUzcO8HNI0Sev0eMhZDzHg2St25+BDO2aFKSHoY4CbfFe/uajjHS3DTEJydYotVi1U5h
	 zVweNZjVwgSgIpEq0phtSF5FGdLAsTWF6rMI6mxPHspN30NqNqaSHvQJnqf4Mksa7nJ/8
	 WLicwVAWbllhLwk+mGfoLsBGrgvrBsoE9F3ERNHPbXRs1hSMG4Panxzcn0Iy/nh4+2Ssx
	 50doLV+ixTtVo3g8vH08o3cyxEzydUHzgpYKIuXhTQKNBlQkNyDdyFcaDo0VMLXlThw0/
	 HJTZhyDxuwIU0KSQxn3XDroAgp/MGG8qQjdpg7NYynbXcb6T5paser63cWVlbYb3lQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CP/rIHgJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 4107D606A31D;
	Mon, 19 Oct 2026 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CP/rIHgJ
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 48EE81F000C6;
	Mon, 19 Oct 2026 18:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792433875;
	bh=TxT5MkEpHy2GUxsA9o7iiZv/Vrk1zXGXHdpML8q2bwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CP/rIHgJgbyuPLLhLxhHSzJqxyorPHg+KuaqpZvyF7/dRlyrUzRiHaECHVwfw8eM+
	 UAsASneoN57gOu09dxpGc/Sa6spO7cpaitneKPo057o7GjFEcT/Y/SSBO4iYqCvrPZ
	 Z1mGM2pNSV3otVdKMit0ykVWVeVkXYewRqWWaFNlmH0FgtTyh2sAkEtqCArIfej/fl
	 pqUIHrsu4RlCv7wjYPSFFbDPJzPxwTMzbmRYeXzLJvaGCeOXdLI+jTzzuyAxX2UWOc
	 xlKxiCVux323Lo7w2nEB9KQkaAcXj3YzSn3UUL1//QGlceKcWjdJfNtlrH1dBdTTMh
	 q8s6oV0MSMA0A==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/6] KEYS: Prevent overflow of quota in key_alloc()
Date: Mon, 19 Oct 2026 21:17:24 +0300
Message-ID: <20261019181732.449591-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261019181732.449591-1-jarkko@kernel.org>
References: <20261019181732.449591-1-jarkko@kernel.org>
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

Check that the calculated quota length does not go over INT_MAX.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Fixes: 7e047ef5fe2d ("[PATCH] keys: sort out key quota system")
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index d4e4a2e89a20..dbf5626a48b7 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -245,7 +245,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	}
 
 	desclen = strlen(desc);
-	if (desclen >= KEY_MAX_DESC_SIZE)
+	if (desclen >= KEY_MAX_DESC_SIZE || type->def_datalen > INT_MAX - desclen - 1)
 		goto error;
 	quotalen = desclen + 1 + type->def_datalen;
 
-- 
2.47.3

