Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792433881;
	b=KdFNEmfhuhtbFDlwtPqmwPdHyZSuRRIiFfM67czS28R/2rA7VHLNZafZrQRv5wbZvTv9
	 xuNUR1u7DQw+m5fhGnMeNtakrl2iu3YX5uhVYOhCmmqbKYwZizRhijUj1xSLYTo9p9W7b
	 jqzxhtH6jlv8Pc85nmehAUWodmpUirqDKPFKOOlL7AyZ/FUTM37g6jAFoTd116EfkqhRf
	 l6cU8d8Zckoxnifir7c86qRqBOWeja2Th2DmX6+x6kp0pcuCdI+AqjEcpD2LBGytdg8yR
	 YXdju1S655y4rPDJfR+yxDMdAbqhKbRsM9jVBIWjhy9oDTKEJNcCRukcIAIY/ZBxftg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433881;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=acg8T1h3CP9b+Pbi7wYrl5dgPp8n7OnwctjB/+c79FI=;
	b=in6fqTMAcDhTFKljkMwngVXReOFW6Aybm9tfA3PSh+Ndv10AQiMpLGMFTQahZQjfrAX6
	 c+yn5l1ycHtj0NHpoaPKMzsutLlvnXEEZwGKmSVQveqNB06/LYm+6TsCKNJE0IdKkN1Tw
	 40Qvw6PyM56QOV6G2rZCMYAiIHwoxFJ+7vvojDPJ4RPAItUEMyGmXSs59xBvCSAowjPN6
	 Pn3TLCCqvId9CDU3y7f0UO/iAUazXXbZxQwtTkffDA6Bat7JNHSSvEYFG2RU7uV9KxlQ0
	 MFGlwCBaNDZR5fRb4GzSZU+sYVOVbIW6o2NQoqH7OoJ6lOhbYnXwlNOmmkLhhE2veaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="k/C5fKB/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 789D3606A319;
	Mon, 19 Oct 2026 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k/C5fKB/
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C48591F000C6;
	Mon, 19 Oct 2026 18:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792433881;
	bh=acg8T1h3CP9b+Pbi7wYrl5dgPp8n7OnwctjB/+c79FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k/C5fKB/vJ25NS3VOcEi5R5Yn0aZiY51Nz1m708LNtFtIBQ8SS4qeCGdF0dfZXMrs
	 uiHg15Lo+SkFXVeNpBvC8skmG4mfIrnb86dY766mac6TYW+U+UdMdk2QtEaZ2Gdr8s
	 TFBCpyaKlP+7dM5fhVTtKScatovVDJ+ERRHzxNAglEV0S0KU5z6nlpr7rcj7MbDGmQ
	 93Vn62qGM3sviYkIhF1TNX0aZ1Xth+9GZsS7QyoL9JN2fSpy8qJGkP45Oiif4dza/E
	 sWMAFw4FJ/jz1Wyey2Jr04td/3g4++Lz7WXXi0dogRTR/8BOBvL869DD9cK3eBb/1S
	 XaXDMYAvJ5qVA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 5/6] KEYS: Reject @datalen values over INT_MAX
Date: Mon, 19 Oct 2026 21:17:25 +0300
Message-ID: <20261019181732.449591-6-jarkko@kernel.org>
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

Protect quota from overflowing by rejecting @datalen values that
surpass over INT_MAX.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/key.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/keys/key.c b/security/keys/key.c
index dbf5626a48b7..fbd608634bde 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -384,6 +384,9 @@ int key_payload_reserve(struct key *key, size_t datalen)
 
 	key_check(key);
 
+	if (datalen > INT_MAX)
+		return -EINVAL;
+
 	/* contemplate the quota adjustment */
 	if (delta != 0 && test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
 		unsigned maxbytes = uid_eq(key->user->uid, GLOBAL_ROOT_UID) ?
-- 
2.47.3

