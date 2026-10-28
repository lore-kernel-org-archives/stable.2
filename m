Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793177712;
	b=eVbwFQPLXpp9wiirIut2IInRcCd1sbPzzkEBvjfOzsajCoV0841e9beagq4F4l8HYsW2
	 1iWPaXsukzoTep2z4ndS/LgRCjwYxdbPNIDqM4anjeDHpToufUyrYJEWVRx/OG3EAlg54
	 HCbRhIvPYO/ru25ZWBAV6yj4TUZVsZA6jB2ALsUSJcw+ON+mk3qdjNzivVs3TSCDh7OwQ
	 nvUJfa8D7k2CXsxxY1Xxhmai2uE/TvQqaSG8DTmt566ZPjbqa3n6tTGgEsJtdU3dxo5+G
	 Oycb+WnmGeEjwMIMlRGyZ6/eVz657eamZbKGz/DYXP+Zb0otEtwRowdHnj+IAUHl7kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793177712;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=imw36QlwCXBvBt4lBSpj5vrnp11EzQ+63TBr3DUlgZ3ERW5oXt3IjIaBs9skaW23erS7
	 qsGXc+cArhOFcqdOS0a+DklkQLUeXKHEDOr/p1JeG4vcBoQK0faxLUjHikR/+jHJHnwaQ
	 hnFN/HJEuOCw3o5NCPR3SYQixTU25Mcs1bSzx+pjetQioUGVCjj8CZpp51WCN+xZcAFeI
	 3WC4+9+RlYKiXN1bcoNNWpHtCYhSCQFld0Staux9L6HyWxjSrz9OOZIaGvMze3WjEvrdZ
	 5IUou+BIcMGnPuacRw/uly4GATbxmMAFj9pjBSdip6SpSppVtZlrAsPbFv47CR+m/Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HE3K1pkj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C2606A31A;
	Wed, 28 Oct 2026 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HE3K1pkj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E201F01825;
	Wed, 28 Oct 2026 08:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793177711;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HE3K1pkj3Z42tmbio0PdwxCuFtxWKXKFq6+hv/73PqTedoUxj5vvZK5Ja072YlzVy
	 8dHbaql57NxaWxphm2fSt6rMtpwCHIKKhhWDd4XcApDfUMDZPTrEi2E0We2l0mALuR
	 oe5YVejCYo89WCV71xOmPaNmjmccMkzb/XMb/Ura7NU1MAy1Dnhk2F6qqOZyyjX51z
	 fgm+ESVhHWsBCdrWv2Q8EgBtPjTsG0tiPD2jkRk//0Ee36uO78erFxwlKLOwYgLGF3
	 XAT0thqLmjZjJWC4ckTAwKn3ZxJXCVJDi/7WR+RiY+k1QddnvgNn+Xo2UKUzx0surl
	 2cU7omvmcXeAA==
From: netdev-bot+sinfo@kernel.org
To: Paul Moses <p@1g4.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 maciej.fijalkowski@intel.com, andre.guedes@intel.com, jithu.joseph@intel.com,
 vedang.patel@intel.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] igc: return XSK frame copies on XDP_TX failure
Date: Wed, 28 Oct 2026 08:55:10 +0000
Message-ID: <179317771001.3327.2393142414431005660@kernel.org>
In-Reply-To: <20261028084919.3059158-1-p@1g4.org>
References: <20261028084919.3059158-1-p@1g4.org>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
