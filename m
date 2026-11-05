Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846197;
	b=SM/10w0TI6RBmGY/1TLzD/YIKhwpBOTG0Vqz3hIeXC+iEsCKtnYUOr2pB//TmHjt17PC
	 6Pw7EJXA8Vm7PPMiFG4gW3PojooPxLxRhuCLiblkpn8IdTiWbDlXwNqBXg+anvALeztxt
	 Zsjlzw1ljRq3rC7NyaSmfGTpx+dyiTFeI5RlC6etosJKmSSQKXnS2z/WabT6x4D2jVMtw
	 1RJDegF9jcqTAGgmrATTeyzWNzWeDFvv96QjuJb5FIC+vTsA29bpxvQwruCtRWqlfSgS4
	 EZJHkL7a9deRgjXLuQFrujcBCPh/W61Q0Y9hVWQ8hPv8ZMZcnsGgAz40zjYpVn+VdXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846197;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lhSycnIWZ9LIFN/+x+dEO/lDhlN94ILRIX2gUL5PBVY=;
	b=am14TnXdHyvwvWkX7sNPmLH2o2gI+hZTN9h2hJEZZoBhAx57mnV+ZZbpuwBtElcg2m1m
	 MyOcg3ezgPuzoZ5SVzQ1bJSVUsGaAK3NK77SZCXOWZBTVZ4+n49KdI15zT27C69T5eJqw
	 X69Zkz903XQmGJRnewTylLcZS/dTmRA9YkN1pew+LdSsV9TWsM5T0w0OBEBZB9fdZ3DeP
	 x1mZ+2FQWpHnNOBynXQgiUbOuaXV6gDdlVSkFGr54CkmSdsYk6desnfalQuNkfXL8rpb+
	 rh02A3soDqMT5CO3dIYdtIVzH8yy51eRHCyion1zDrpcv+iqlckfD9sSz7LqnGzyRtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XtI3Wo0m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE259606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 02:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XtI3Wo0m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8981F000C1;
	Thu,  5 Nov 2026 02:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793846196;
	bh=lhSycnIWZ9LIFN/+x+dEO/lDhlN94ILRIX2gUL5PBVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XtI3Wo0m52iv+aoFKU+Z2PQ1T/mh0afeaEZBeflKzgSwtRsZpyFangjj+GI42f6rt
	 Wv1V+6JrNfMAO5S32lmy9tCzgTpsvkZ5WdqYfL39hTxQt7acksriZ0YIDvRBmKTbZe
	 qVi+AxlS4JLLGvEsEIofsMVCMM/f/fU0ASbrmissyW8sEssGeNTuVEe7oxZ3Yfabzx
	 qz+g2WRpTl4rNmF57ZffEaHt7i7DQvtwlaQtNvrAbSKKJCXvJbIhzG4ejO5s9a2AAo
	 v1HjjjKm24kKYcw0R248dC8gM+WH6s2PJ0l9t40OWUAqSc+wRYUov5q5l4vk0eHeyN
	 bxWXhDRbTpbRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Huth <thuth@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] smb: client: Avoid leaking sensitive data to the heap in connect.c
Date: Wed,  4 Nov 2026 21:36:33 -0500
Message-ID: <20261105023627.1203080-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110420-hankering-baffling-100c@gregkh>
References: <2026110420-hankering-baffling-100c@gregkh>
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

From: Thomas Huth <thuth@redhat.com>

[ Upstream commit 111a2b8717efbd9729d36828308d5163fdc977c3 ]

TCP_Server_Info contains a preauth_sha_hash[] and a cryptkey[] array
that might contain sensitive data. Thus free its memory with
kfree_sensitive() to avoid that we are leaking this information to
the heap.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Stable-dep-of: 482c117c6dbe ("smb: client: hold server info until cifsd exits")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 2cbbbf0c93b80..fa7c2f70b6ed3 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1147,7 +1147,7 @@ clean_demultiplex_info(struct TCP_Server_Info *server)
 	put_net(cifs_net_ns(server));
 	kfree(server->leaf_fullpath);
 	kfree(server->hostname);
-	kfree(server);
+	kfree_sensitive(server);
 
 	length = atomic_dec_return(&tcpSesAllocCount);
 	if (length > 0)
-- 
2.53.0

