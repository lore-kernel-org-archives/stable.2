Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180114;
	b=0BnsLeDZ8i5HcnT3NtaFrswNI3rI7kXWZnm48iaTi2q3vEvGnPl1nrTPd4K5NaOVyXNd
	 IEOsG84VmrRgtOFaNJpCIjrdqVaKGfdC2WjpPSC9AmMOID9JHJVaQFBlBBOWxdmY+HMTX
	 ezzYneKr4OVGefYRYB2qqe+yarjeLy7JaMblMxz5VRwWDmtvxG/i0dJS5KJO/rsrC8vX5
	 n/c12GebYJQfhdltX+xdf2jCnexW1TZDmjwEOzkuA0iqFMxvsurc7ma/wxvdxJBrnXXOU
	 fK1qSqmhD/aaVX1NkjCSTgzSxn6l225pFkiahy4GlqMacW6wEfvDlztb0NZ3FC7s9Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180114;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=ZsxRJKijty1zRobUXPopk9EtvKbNkSPU6rWA7f4kXlpcbn7I54rwlLveT5jpEsaRNWS1
	 XXPmjAVQMnAJZxeQWHcK7NG/btgCKY4hCD9evKCGnH3Pbq5GxhY+LLylmOspbc2Y7OVql
	 BZxt7UUqe3HBkLiDfMJkrdWTEkzDaby7ekJhkVWSa5XA7MDs4ha0gg98HIKWAWSSSOtPq
	 Vv25eC3xdAObu5MFeZJX/sfdlKVW37a/BYrFyGfQCHXRDw321KaFDd/gDM8oYCkFdBbUW
	 bCJtmrWKsKYhRiGoiTaXs89REvsjEqVzwBHo18g58v1Cv5QHMwzsVoGHLY/bkGFYGFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jm+JVDtO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15FB606A31C;
	Wed, 28 Oct 2026 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jm+JVDtO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17091F031E1;
	Wed, 28 Oct 2026 09:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793180113;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jm+JVDtOzL08QE94VDIdTbBTxhISjHMjZYYx5bAEmWItmStYqEAKrV3wRjEmf62mz
	 gFLuPEnlP4/juApeHr/V3NPuliSgRr4fv76OzlrqFyeQHuDp/tJqKVB17+Om5bmXRZ
	 EOBBk0uxGCW6pOrm6gkFbfPV9S+enFkBGluQhGpa/V1cQTehh07QdIQjjRuWM/5V44
	 hrKoMv7XeXF7hbkkSwQjQafc0vmXhoKIoZsFIlI7zFxGZb89XA7gisd6ZLzGJVOAXQ
	 SwkwqBhlCPQTjop53gfZdXKPP2Mc3EN19FR34SLHNLlWFy5J3Cg5tI/ohE4a2fnOu3
	 C21DyAb0W/P+w==
From: netdev-bot+sinfo@kernel.org
To: Linkui Xiao <xiaolinkui@126.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH iwl-net] e1000e: close and reattach the netdev when
 e1000e_pm_thaw() fails
Date: Wed, 28 Oct 2026 09:35:12 +0000
Message-ID: <179318011223.3327.3243826211150431182@kernel.org>
In-Reply-To: <20261028093117.2313438-1-xiaolinkui@126.com>
References: <20261028093117.2313438-1-xiaolinkui@126.com>
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

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
