Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794907634;
	b=ZI5Kcu5VHRlmQrtk/fkjOtOpyIbqBu47pg9b1wgwDVS5JRG1GwbyvUJqmldTZ+q08Dgf
	 HSoNFpnTVpPd08MpLR+fYUpOUkZ+o3BiQdgrl7qnr+II+PP4slgvjqusyxsL2dQ3Wg/4U
	 envPfRVen6pkZLICWvnQDcTj8WUGl+bN1d8R+vOalLrm7ycIKDZt9/YPHuosKxQlnIZuy
	 9f02J2vne+FeG9tef07T39ilB9eLb7YKIGv/xwvPG8N6urDg2tn5Cf/h0DdksrxwMYgLQ
	 /FKuyDpPd4mAROKV4szQqdgAX8oseDRQUAjMqekmtXoMqB6d4Q6f/t4POWvG5nrdFhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794907634;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	b=ewnbn/yIOj14QSqSFbaPnM3l4N8lRfbCI82VdY6axcWIQ5Zve3ZffSX0g+RGrJxMNfxA
	 4YnpwFA0gyQ91b85TjIbxXul0sDRW/4EjBKHSm1fv/Z7WnA9NmPjd5icwrb5CLetQvrQs
	 r2wK9ieJRjA/hAg4hOVAO4UjA+2YCwGTs9KbfmzQrV7aYM7/sk+lAZCytbXhNih2QdWoy
	 YrLqwavomX4PO5r8E1H3uVPNBfJttXcw6DjGwjsCO91GF2zPFSqu+PYP9U4MzWe5b43cz
	 +45FSEsb0PH7GZQUkRJl97vK5pO1fbJZpI6Tv5kI7L3Ew3N/FTsnSPu/mM0+EnimfUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GlTJiHtH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADC1606A330;
	Tue, 17 Nov 2026 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GlTJiHtH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7051F000C4;
	Tue, 17 Nov 2026 09:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794907634;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GlTJiHtHVbvl0fkwqx0uenezTssE47Q4g+SemH6eKAkVX7QowSaNribnn/dhFRuF/
	 HSz/kNpajjXEkoJ3dU5E7mP0Gz04yLy6SAOPkHUPJz4E7M6eWAmZqRvD/wLOJKVc8x
	 gXPu9zki27XZSEtUQxy1k6xOo9DMwVeuv2DB8xGBZq+KDh9DkJuT1HTQYFoqY/VKY+
	 9t4FvL5GIFH+L6aIj0Q6k0jOhGL4EaVmOunL/YtsTkxugH3OJk/WZzFTzCz/xCGDSb
	 t8wjaYWc9eKcI9KzBRYYH7Eq7rwei5l6+BwxUWWkJmlKFXp0lFzm0D56k6OwLYTPC6
	 epQvJGTJ6HgiQ==
From: netdev-bot+sinfo@kernel.org
To: Hyunjung Ko <hj351016@gmail.com>
Cc: James Chapman <jchapman@katalix.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Chris Elston <celston@katalix.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] l2tp: reject short IPv6 address attributes
Date: Tue, 17 Nov 2026 09:27:13 +0000
Message-ID: <179490763326.3291.12558236650605974154@kernel.org>
In-Reply-To: <20261117092157.85513-1-hj351016@gmail.com>
References: <20261117092157.85513-1-hj351016@gmail.com>
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
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
