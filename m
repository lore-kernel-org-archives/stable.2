Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441007;
	b=bKPUWKYzXoRcF+XN86DEchmbnzFTfmvkSDXxpYDNn7cNmICItRm88eVXLZNkDGp2zMig
	 DB/AdV6vvgCF0wkBmqmPK6xuta5CY+D6QWvutr6/uaknGC3t80nJNqY/+jaqthJmYwnMn
	 xfAwjVCUslg8KanGfyZPkd9qQz/fOXxf2t3P3skWupTh6hX0eThFLnXNEX7cwhb/Kzftu
	 /KbADPrc4CWNPk44Un1IfHd5p0df1xWAL8BWB9TC620nWO3fbkVCe5cTPsQh9WTuLZxut
	 CAW0a5cT1WiMXTEKSMm23bafr3d7fPu9SKpV8jl+/o5kAyZj1QDx56BklIPvPWTGE1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441007;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=M/2wx9+MZCxwSiteUibVzTKd+q+7NQqf5slHy00WdmU=;
	b=uzersDHnXt/IDxrb6cH8Dt3ldo84phNhCEoHQ+V6W/vA62A2bivqUXhhNowYW3cuIEAk
	 sf0Q/dQeI03sOEI7bIauojXNSQ31FXzOl3op0e+NyF7lcNEcRgX27+h4vK4zV47MrAMjj
	 uvQ0RsA5q1/89F4YAYS+hKR524GQEurBpgCK8EoEtz1ZE9gs7gBganaMGaMXoEjfcEsep
	 u7bG/OyJHX5YN/Z9LqbmwFnImsAN/ZtrPzOSi036DfL7nh8pIw0+H+WWUhzHCSa8hqf+W
	 FCMDTzm/q3HxgpjBHIIREfeOcMnn44CmNTAbMXg8QmqfIYNGTI+ZBlF26ol9/H4SJrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ecYavZI2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FDD606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ecYavZI2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F4F1F00A05;
	Wed, 11 Nov 2026 23:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794441007;
	bh=M/2wx9+MZCxwSiteUibVzTKd+q+7NQqf5slHy00WdmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ecYavZI2XZFuA6zzwiEjm4zP3mnyjnnByb9Y0K99eC0R44NEpyMVkVBJEhFZLRoZK
	 fY92lWQSe0D16z1fW6qW1P8X5M+rdteBseBTODXldyJnwgh2IPETkUbLgn0WrUb+1h
	 B1cEWCOzmYC30WiAFqJADAqnIua9pZ416rgC1HRlzE8s/rT8fPObv+Ny+H4k/SaiL+
	 F44wjnNY1M3o3o31Mgm7WWnsGUR+S7yDN7JLIdIsSLLBEI82QN9CscWA06zzzYLL5p
	 dIZ3kaMhjitNPGRPcfS/VNjjRDdsqz1aW2rUmA879IteA+MAL9tGbmBrFfPltYm0qc
	 wgsIN8PBfyxfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ksmbd: revert fsids on durable reconnect and replay failure
Date: Wed, 11 Nov 2026 18:50:05 -0500
Message-ID: <20261111234956.702269-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200243-failed-6.18-539223f18026@kernel.org>
References: <20261109200243-failed-6.18-539223f18026@kernel.org>
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

From: Ian Bridges <icb@fastmail.org>

[ Upstream commit 539223f18026448f67d33d09719c355b91db7fd0 ]

On a durable handle reconnect or a request replay, smb2_open() switches
to the SMB user's fsids before calling ksmbd_vfs_getattr(). If that call
fails, the code jumps to err_out2 and skips ksmbd_revert_fsids() at
err_out1. The user's credentials then stay installed on the shared ksmbd
worker. Later work on that worker, including other users' requests, runs
with the first user's fsuid, fsgid and supplementary groups.
ksmbd_free_work_struct() also warns, because work->saved_cred is still
set.

Jump to err_out1 instead. No path is held at this point, so skipping the
path_put() at err_out is correct.

Fixes: c8efcc786146 ("ksmbd: add support for durable handles v1/v2")
Fixes: bb8bf7eb13b5 ("ksmbd: add SMB3 request replay support")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: omitted the hunk for the absent dh_info.replay branch ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index ec4c54c9c6dc9..6ad50aab3dfcb 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3125,7 +3125,7 @@ int smb2_open(struct ksmbd_work *work)
 
 			rc = ksmbd_vfs_getattr(&fp->filp->f_path, &stat);
 			if (rc)
-				goto err_out2;
+				goto err_out1;
 
 			goto reconnected_fp;
 		}
-- 
2.53.0

