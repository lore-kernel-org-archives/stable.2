Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793438908;
	b=VGJybkNzerQ9kK/QGOxxeWyw4aeMObVjJIYmuxklfkMUsnL9oXiwW8zwcqXnybmTGt4M
	 DT3xwWE3Idyv8d1et4u1jpzwSv5kOlRv9WEiINksol/FFBkJThqhowwXrNKjNC8cV66vk
	 +RudNvKUw+wwt/62zOpweqsTtQgoHSo7fKhLaeWXI2/muHsXGdWT8GcKL7uvr+//+eDZQ
	 RimcEpls3zkc4oLR2BZ8uQH0hUVCTKBxmYhh0OMbZqmc2o4EMrQNAiuJuWkuFJsi/Dk1g
	 gCc5tHolP0oCXXyMDP0txCT/4UuQarFacTo0TPa0CzM1yL/sOo/bVARFEBHPjgz7J7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793438908;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hjlx15+/WpY84ogewYYrVLgz+B1Dn4l9XY08MaKTAGg=;
	b=2st52tQcl/9HB5oeV2BY4wxxBKJu6gGw4CDYaGpUElKVmzpO0mgH4ZZfJVvqWh6PcGBb
	 8IgsO3AiDYOQw58YqY1cMRn6mCDYgS6jgidqgAAQJheLh35q0GwzeQxJG+aTeBCzTqUVE
	 hjewxLN3SCqKvTWxt8jnqTi4jJXn+kasP2zI/CxREfITLnCnbLZa8nNWPht+UWzTcBcsc
	 9/hw9HlQa7bXU0A0k2rlD/jpSi2oiSTe24LEu+TVcmBJIgScbCsHGVAlbX3NPcr9buhNo
	 xiKZTDDAzPFMywZ1oa2sVTbnnBbC21z+9nzGvebZT7bGtzXLb6dzAzUCip4RxDGrnmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f0zzDpMu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id EF63E606A31A;
	Sat, 31 Oct 2026 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f0zzDpMu
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 034991F00919;
	Sat, 31 Oct 2026 09:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793438907;
	bh=hjlx15+/WpY84ogewYYrVLgz+B1Dn4l9XY08MaKTAGg=;
	h=From:To:Cc:Subject:Date;
	b=f0zzDpMuxAnCwW2OVLdWIJw9g2ks9oB3Pl/9WZEuKHCaH+6tTHttBtgZSzXTYHatA
	 zZ6cPb9wdgNCZwsOPCMtJEfFhGPXMIzPXi0OA3IpOVOEXdMyF4bEYKT6F6zir3359x
	 Rw0bn7z/L/JUUYJXXQW5CKLkWqhc6/NXvWIV0lWjBeIOS8nfaU/2Ui3e+6HPxmrhCK
	 AfWOhJ6tgAc8brtbRWSFM7LT0gmiWaYNhYsix5t9NV7e3Z8ZN7IXZY1lqRrG1sZQBJ
	 ji/BWP2SFFucqj9fihHjOSAImBy/muE/HJ9uQ7t828M/4zEyiRto321EhJGuR1Dhop
	 EWvnVob2tS+qg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Anvik Loitongbam <permissiontogallop@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	keyrings@vger.kernel.org (open list:KEYS/KEYRINGS),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] KEYS: Reject restricted dest_keyring in construct_alloc_key()
Date: Sat, 31 Oct 2026 11:28:18 +0200
Message-ID: <20261031092820.497238-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
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

construct_alloc_key() links keys into dest_keyring without checking
restrict_link, allowing keys whose key->state reaches KEY_IS_POSITIVE to
remain in a restricted keyring when instantiated without relinking into
dest_keyring. Reject restricted destination keyrings with -EPERM after
__key_link_lock() unless KEY_ALLOC_BYPASS_RESTRICTION is set.

Cc: stable@vger.kernel.org
Fixes: 5ac7eace2d00 ("KEYS: Add a facility to restrict new links into a keyring")
Reported-by: Anvik Loitongbam <permissiontogallop@gmail.com>
Closes: https://lore.kernel.org/keyrings/20261030173930.40948-1-permissiontogallop@gmail.com/
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/request_key.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 22cd66a44da5..d4611dd7cb49 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -404,6 +404,11 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 		ret = __key_link_lock(dest_keyring, &key->index_key);
 		if (ret < 0)
 			goto link_lock_failed;
+
+		if (dest_keyring->restrict_link && !(flags & KEY_ALLOC_BYPASS_RESTRICTION)) {
+			ret = -EPERM;
+			goto link_alloc_failed_unlocked;
+		}
 	}

 	/*
--
2.47.3

