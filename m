Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792537994;
	b=jvkj5a0opzc1X3DELHDsZ/XfawJiaq71ybNkTOIQPBjiCG9xtgo9bYENoYT+hUjEdrMJ
	 h+UPItTDCDSROoLG7gpC5ettCmEbvs0iaswOdGpDTi6+lndQf+v/UCiCjLRzYazsD8538
	 GJGHtNwx/27AW2oJIlDx0pYsTpgi2yUS1JFLKU0YI27dJJzAyfNVFEYGHfEFMML01CPDv
	 CVUkpviw3W+MjJ1gUbfwV7MLlKniUfyOaZ5oxzFecU7D/ynq7uwh/4ble7V258g+DngW+
	 rSkrugfubSvxxHqOhMEMzwpd2qdWaJ0cAYSq+CPMjwk1pS/TUqXUM1bGXvmQACt7CAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792537994;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=NWxA24CytdwkdOrv03/wlm2TUhEJN7XqEV98/ODj8WDkZrusmQA2Q/c+lz0ZyDpLCmno
	 jVupJbCNAGKlOUpdugonjtMs8yQ9pkbejoUVL60F1ON4FRGDILu5M1x3hDvhGdVxiK3QO
	 f7PYjhubWO1r11k0zFDhEM5ntLKgfbbN8fBE4tPhOYZQoeXO4jM/j+CANlrFqa4X1H93u
	 xtf2k+lfJRPa7Dw9I6o0yjgNulvgifzMExemZiFj7E/VdyR3suWwNme7u7aj4e3wZOxj+
	 jJd+5bXJ4kJjgIoauM3uiR0DrA3pYipAKt3zb9a7wLyuoGnm6PrEdaZ3e++0TDOBqSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G9V3v/jp";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C4B606A31B;
	Tue, 20 Oct 2026 23:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G9V3v/jp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DE71F000D0;
	Tue, 20 Oct 2026 23:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792537993;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G9V3v/jp/KM+nkS/IAzzInf3E5uFZ1YnAFajQFVDhwn/pJ8pNTif6zcGBujvf7ZHN
	 C03nOxjwhuqVaivQQIjb20SoMTEYxzxzU23G+ib2CZeAUKqsvaMRbGTjT3rhLCc2nz
	 I1VGzXw6Ck2YtCSezvd1x2x6nkKHjigjWk4E1LqS9v0dONM1rKsQiWqF5C+j3uNZyN
	 irfeaLrna8JHsb4V7UQE+fIS3YdKce0FzR6kf0U6LWfRZHbqIiRwCfd/2Bkpg1N4j4
	 z7EGzNoH8Zr6XS2y4JNLP4fGSCRH4/UftLRm1q/URKDsHBfIn5+jjAOC/GshBsqwep
	 nz060x40b1cVQ==
From: netdev-bot+sinfo@kernel.org
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: 
 Re: [PATCH net] dql: Reset the adjusted limit when resetting the queue
Date: Tue, 20 Oct 2026 23:13:12 +0000
Message-ID: <179253799214.3290.9079364522070765674@kernel.org>
In-Reply-To: <20261020230358.6649-1-dennylin0707@gmail.com>
References: <20261020230358.6649-1-dennylin0707@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
