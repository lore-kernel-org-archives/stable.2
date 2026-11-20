Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207170;
	b=t7B8M1vn4kdubUjHbisOk1oTBHNNcIHAaMCqUBpgH/cuURG5AvwdYeWKU+ggfVOTh2Wa
	 Hs4+gIEHbMrOx7G1G4MfZ/DCvHzIR6yMIh7FPhsz3XqSNInq3oNpdPnHHcX1cvKxJfSZf
	 T3s1+BbEfzZqyH6dpnrkamVjbWvg1xyO8LTsQEmlcFLw+9zMaWCxMFYbmS6rYuzwuwji0
	 mm+XWNrOjdxqFlYFncBAiDEeCYrF4TihK8yIMiMpISpDKEkPu7tdwYLm5U0LRrFz2A/JG
	 EmlgN8c2Zfu6MP27oJOviA/r7lUDiatxO7h6ZJUHiFQZ4ObjpJbgiWRE+yXkN2ViYCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207170;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Q8G+mvi3U4u/BG5qsE8xw2s9KvrWIiMDF13/g4hzgFw=;
	b=yW9HCCvOoczGY2n1HItUMhVR6HwXzOVRYk7ldlppPx9NaA89fdFAImGRyasumO8Ujdt/
	 n/4gSz+EsT97n3AknRicxRB9vtR0sxlWauqKEfar7c6D0w5hcucHyuWu+rT/4+pXOqrGK
	 yAV81Sj4E3aXO/Wq3bem0kJPTYGfJ3i2Ig+ECr5v5XL5AdN+74QhyUqbgwiMN8IEhcocY
	 EkpgTtPW0y1HCWw2NYmmmqAF4gQUdvwPO4SuQVAbXQmwfLl4UR1pQTAOOeix0iPE8tEFv
	 uSU+ssWFQkklsLp+FKjbdzzsxRpGIo7HoA545mo2I/22lPhDJOO5g3vxW5aSkRLDL+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EYkyhytw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AAD606A6E5;
	Fri, 20 Nov 2026 20:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EYkyhytw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB5C1F000C4;
	Fri, 20 Nov 2026 20:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795207170;
	bh=Q8G+mvi3U4u/BG5qsE8xw2s9KvrWIiMDF13/g4hzgFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EYkyhytwELOV8CIzFnTSRb6zhAp15/sAemOYppOELKMsFK7ivr3CdUJjsNWkuKwV9
	 BMs398ePcwfJpzq3N/DKddxtrtSD8oHveMf/XWSo2+dzG2kcB8HPcF1ArXF780OKEy
	 0Eyor6CRi7E/DAA/QbCDtW3Z1Ow9TfyuNqh3b43vO+OQ6fO7bzg8BkdRl97bMpp2YJ
	 Jmw1MwByj5JZZlOHzru5LdQpMOASrH39AfJqpQ2U1B1qrood8m+a7O9EieTjSsaoWS
	 MgFy72RW+7AeF+YGW4u9ZKocl7rkHXDS0Ic3htlqdpmgjSPwymwzxmPIMBvCaWTCPw
	 mKZDcM1o5sBIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Xiubo Li <xiubo.li@clyso.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	=?UTF-8?q?Jordan=20DESNO=C3=8BS?= <jordan.desnoes@francetv.fr>
Subject: Re: [PATCH 6.18.y 0/4] libceph: add CEPH_CRYPTO_AES256KRB5 support
Date: Fri, 20 Nov 2026 15:38:53 -0500
Message-ID: <2026-11-20-1-daily-reply-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119-aes256k-6-18-y-v1-0-bd5db87da2f5@francetv.fr>
References: <20261119-aes256k-6-18-y-v1-0-bd5db87da2f5@francetv.fr>
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

> Backport of the libceph aes256k series from v7.0, as discussed in [1].
> Ilya is fine with it going to 6.18.y.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
