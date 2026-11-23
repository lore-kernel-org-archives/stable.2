Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461915;
	b=QKFhZ2JGwwLJtUb5s2hdO2lT8Fz7iUMYppVwvx9/MZzwOJlsERBCJKQQBfdRojNEAVJu
	 MEXYuVPKjcGqVnCLt+183Ix0RCf5u8Kxa/9hTDJXTvDIDT0zBDrHu4g7nI9UXXIVSNUxt
	 3h5aOLPUEeK8v5LdAHUa4QYZ3BqNBUo+a5BRizy2BD58QBo6icLtUVf/ZZcM5wNw1Vsee
	 gqjZIJEAa8mm9WATR3iMNd5I+ZKWswB5gGdeypHIXawF0a1hJr+LyJ4a5CQL/KsBMX88e
	 bnPqykTtGVSZkofPeuY8rkUL3HhdNlkiAgP0JMX2LlKHM7hZ8/cDwSWh5tGBnIsApyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Ivc+yZF1e+YkHBH2XdPHCIshByex18b++1Ftez3VniI=;
	b=quEZpipBCVx4DitTl95RwNg08ptgeR2JdpFeYlXnVEDawdSSlF8bnro+RO3dKt00b0Cr
	 iAh18D+hk05uBg6xb4gXWQ8DwX73iM71H6KEcPqtZzeJr3faOcGBuINmDbIik9v67AqMh
	 566wGYUt7Aqd9wqJRGInH+HQ6fn6XZ2VtMbc2Ny8w2Mx8MwTDz85zxWGV3+1jfXdTWwJX
	 B6x/j7f/RgE3JlA9BaZMyC+Oj5JV0uPkwgeEufP7rwCoCOSDfqKuuNcwueV3yWo/k8RsJ
	 Dy23Y5jb9mazMTR3DvTTY5IyMIgO1grEXXfHRM4nqNdG/T4LgCSezzdsDNiSp2k5F5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=InABI5AX;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28BD606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 19:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D28BD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=InABI5AX
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so21150735e9.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 11:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795461913; x=1796066713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ivc+yZF1e+YkHBH2XdPHCIshByex18b++1Ftez3VniI=;
        b=InABI5AX3pKbG9IQdQzgyiryQgftPzVdm8SbCVlAtvY6rv1Dbtd3WqRdOsoSQNuH4Q
         3Hds5U7UsF6QV8qA/kmA2nRBZ4Bo3v0/ytG7/lYk+1RArBNhdK7fiIVbuC3ll8By/hi0
         Ikf4sYbQPmXmxTlwH+35fLzxfkcgAfi/mw9Uzruc3wtQN/4hWf7yzDrpAKG5QdXETgzH
         sNJZq4jptTzE51wqCMmE0cg/8YPaNt+NCpP+wxH4fX2qT2bPokgyQ82oIdUI8kOOv1Kn
         mYJsZKAzW/NPFxLiVy/8eLQxuR2qnqfuuPnxRRk4prHaTeLuB49nvoqgY1OPh75ADAcZ
         CwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795461913; x=1796066713;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ivc+yZF1e+YkHBH2XdPHCIshByex18b++1Ftez3VniI=;
        b=f/G4NUxz3q9ksB/bwSwP7/pUc/zB3QDR802VqEiJcHsTz5fQmL5OlVm5VS2xSXjBRI
         y8BE5K0j76WP0F61SEw3ahapc0/AjToQulp/IlmrmWsHOxbnbT0Tc5o0wJ3enpA66mm3
         doRcGelRpVPiUPQDXam2yJL50OJwNhdo9iXbEd0C3MmzT8lUGDqaCq7qmdhzu6UTs6A2
         HE6E7eiI/xYnMhlXViEHhKPVbQajo+ITxjyAwNtZril6jQgTYG5wnzKBo9Gu8UC8Ftyk
         u1iM5NnpoehwZdmmpUPmEHxlkMtPHmskIMCosEjO/8MoiKc9MiY8MuRlszEMXzhZOdnk
         LGGw==
X-Forwarded-Encrypted: i=1; AL+hErHmfcdCewPw2py8nGJ1uhYlUJoRo05tpiYXTRy7I80bTEsecaPNQfH1uErMNaNPNAaDv/r26zQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qVrNYwRY6DbdOBu8lVbijybCYsM40bzZrQKsyIybtBBjZ0TUC
	aUmlIQu/MH9SzaWhp6CxIioL8o54YwuO4KjiasFED35iqvdZejpWQbTb6yFchFlkL5M=
X-Gm-Gg: AZFdTZffca477UBJh/VV614aNj1buQUfgPhVS+0VOMtmluoAeuVY5J5LXu3qwdysyk9
	F0u5P/lxebUW4BC1ppD0XeRdDlS//Wkgbvti9x9BbqWAagdX5cjJHIOIF522sWgLJUxCe2UL4l4
	98neo9X6coE26IoegYBFIc716fIGpNWzk1c0akUZR2h1tuTxgzOtLUTW7GHQ5XMAxs7AKQCQoAs
	j7KX7uTXyJ/OzAQtRzUCHhsq94RQsX9pUE2MzjabziDEfPx8KC2gYprnbyBM8GbGTzOd3rLo88+
	l/AzigSUZr8GtRFEclmznyt4BDC2Q+pVx6aYM20RtkxHfhW72qM1YVXFwpnbprt3/i8qgCTz3+K
	Mv0ESWhR6RhFBYI8s6C1KbOQvzGxwq6kSQgWNE976o3laVeB84HZOkBxwRGN61v0jkBgdhAasM1
	vhVzA86SeEQ/62lTy9G5Lw0oEUf6rdaqjhMRGnqtNoBfWJVjOmABvwzjsZV0zktTbBCP2SsGhDE
	err78iRQzKs4dS+kqax5oV7vLUatl3ONj4FEWkJ55c6KbmuVMcwP7kMgYm/iD5U3vc4PSMdk8AN
	xnDos2sgtJsEaWmqgyM=
X-Received: by 2002:a05:600c:670b:b0:4a6:30c3:1114 with SMTP id 5b1f17b1804b1-4bb88922df3mr240330235e9.12.1795461912931;
        Mon, 23 Nov 2026 11:25:12 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884911e3sm442986305e9.6.2026.11.23.11.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:25:12 -0800 (PST)
Date: Mon, 23 Nov 2026 22:25:09 +0300
From: Dan Carpenter <dan@pereq.eu>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
	Fuad Tabba <fuad.tabba@linux.dev>, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: nv: Upgrade sub-page TTL hint to maximum size
Message-ID: <awSTFVxQQuz1tbk4@stanley.mountain>
References: <20261123182312.4842-1-maz@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123182312.4842-1-maz@kernel.org>

On Mon, Nov 23, 2026 at 06:23:12PM +0000, Marc Zyngier wrote:
> Should a guest be slightly foolish and submit a S2 TLBI with a TTL hint
> that describe a base granule size smaller than the host's page size,
> we take the resulting size at face value and feed it to the S2 unmapping
> code. Which legitimately screams about something not being page-aligned.
> 
> The architecture allows us to drop the TLBI on the floor, as we don't
> support a S2 granule size smaller than the host's page size. But it turns
> out that doing so is proving pretty hard (we call compute_tlb_inval_range
> from a number of places, none of which is amenable to an early out).
> 
> Instead, detect the annoying case, and pretend that we don't have a TTL
> hint at all, leaving the size upgrade mechanism to take place and use
> the largest possible size for the guest's S2 granule size.
> 
> This will still allow nonsensical stuff to get through, such as a 4kB
> level 2 (aka 2MB) from a guest with a 64kB S2 base granule size running
> on a 16kB page size host, but that's not worse than doing nothing, and
> the host code won't get shouty.
> 
> Reported-by: Dan Carpenter <dan@pereq.eu>
> Link: https://lore.kernel.org/r/20261123-inval_range-v1-1-815e15797089@pereq.eu
> Fixes: d1de1576dc21 ("KVM: arm64: nv: Handle FEAT_TTL hinted TLB operations")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org
> ---
> 
> Notes:
>     Reposting this as a first class patch, as I'd like to plug that one
>     as early as possible (and Dan has plenty of other patches in flight...)

Tested-by: Dan Carpenter <dan@pereq.eu>

Although obviously zero is handled on the next line so there wasn't
much call for testing, but I still did do the testing.

regards,
dan carpenter
