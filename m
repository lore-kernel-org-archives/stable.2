Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794846380;
	b=2swjXpgbz1SlQT4EcIgY8hDQTict6+iJoiw+XKG/DCxRLdMQfVi45dM6+bBS8QDghPnM
	 H+/Gv9k8A02XNs14YItbfj8drSnsVvqzD5JDNS5GaQrOqrhS5lsjGGiiq4FGwKbI1atlF
	 aTxv0aywVzYO+arqva1yDQa5K0O+MbNgYqoGYC6RbwNUqnZIHQd3lf5HvNhOr2ScCEZqI
	 QEvJUIboe34PE0DciW25CMv43n3f7WefBxPkeaJWbyhS+l0OYFu587tNMQr8WgvR97cYi
	 /DvD4n+mnlJPPbHgFYCbEx6kABhp6JOyKJAIpXqJAUCkcxLrESO6U0Jbg52aB98RDPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794846380;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type:
	 Content-Transfer-Encoding;
	bh=el8d93zMmoK3730cZgDGYBHAUW1uMbGY5llQ1l0QmaA=;
	b=LSZHp58WFGGT1+fi8iXyQWPnP2rvFTEXLjJwvbYy8tfmlU0nv+7TnY6o+xN+QKvvpJuw
	 1VZYMb/vv22CYToTkdLmxMgUiHvveFlI69Xr1qDSbr0xza6s/It6ggXi84JIDhy+T1Y57
	 dW3YCpEOamd0LHSMam7hyfSW1AK/jJQzbuWFgLLcEILq3WQc7m3NmCMXzBYz7xqyGPo77
	 Ucs+EteHKjIFhZRnmGIUuMNLxqV61mhDtqsE+bH5iu9EWWtihX1Bf+WaGbsfsRB1qTtCo
	 fSL3j/QoCB7wqDOdlg1pJfcz3coI0vlRXWXuGHXrtOq11PRSO1qT2+YMzvcNSwpeo8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFH8oE3j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A4B606A31C;
	Mon, 16 Nov 2026 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFH8oE3j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905361F000C9;
	Mon, 16 Nov 2026 16:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794846380;
	bh=el8d93zMmoK3730cZgDGYBHAUW1uMbGY5llQ1l0QmaA=;
	h=Date:From:To:Cc:Subject;
	b=kFH8oE3jYKRBtl0CqdNk5ryHRd+Ibu0BtNVER/rRevWL/yeFO4uUVgxF3xWfM1X5O
	 i0Im2Z6zWcoVc/RP+fhw4dCry6+vEpXYnfNqtO42yyDMdggRk2BO0yhxtm1uQHTup1
	 KT6UC3pOsHlvqHTEUR19bhxYWft6FXP4prjZ5e6atRn8YPjTpslywQBAy+ceuFdPcr
	 pT1ajAq0W1vN81KbbMXMlAPJV/5tjeWdih6Nm8rOhxOdYSCHOesAwsI8vt+TOzx1mc
	 A6vcdR1u4DoKXfnvLLuQx5kK2nnzkwdLXajdV2VqZE1RSW5dprkiNaifl26kh9wZ3c
	 hImrQ7NlyD9YA==
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfauth.ams.internal (Postfix) with ESMTP id CEC33198003A;
	Mon, 16 Nov 2026 11:26:17 -0500 (EST)
Received: from ams-imap-19 ([10.64.2.39])
  by ams-compute-01.internal (MEProxy); Mon, 16 Nov 2026 11:26:17 -0500
X-ME-Sender: <xms:qC77avr7X55MFxK_GxSUL73Ia_Sst4EJKzb1MJxirqXf_2pFf54cRw>
    <xme:qC77ake5R52ZZmGggure-ajJLcEN75NSCGQa9xCxW4rznomwB6pv0quJX51x9mD-c
    fIdL5FBXrzD9G1RjjdVLwLHxj0opWYPGHA8HAHIH1zzKbRwJTRGqSWX>
X-ME-Proxy-Cause: dmFkZTEVjODQyY7bwh42kqvhWgNksmGbt+kBkz1tGhK7S/YMaT8oPDjLGdp244yR+Bjc08
    Q2ua/VrP83KB201cGd4UeAlHXKYdrstDJiEDG4Xb0IbXDx/+fGI+wkKcr6zLr5yGd99mNt
    mnV5l/3qJ04/EH/5fCrQklrrxt9vMvAnvxCMNVrrELL6vzxhxdwW3knr+H9rsN0Fr4rRN8
    y9sngSwVpNJSb6EmJV2bLUDeEUTPAIh/H4onUxoQLUvYUvC9MoI3j00oMPsWW4jKzLZguj
    vCB72yCxgEFN/rGydcZdthAeq28kRjlfQQPsh4RFVZ+45yKy9gI8mJY3zugu2ePJC7YvYP
    HQZuls4jRBsIhRG/jgFpst+gbjuwNps1LlUBATdRpptBXcJa00gtwFCtcTD4s9MoEXtjlm
    mHUjacfXnigjUrrpkfB+nSmQUVlN/MU8s3ISPgCPRaQRx+5nAWDzg31Ains5s6HGAcp254
    /4bg4HWOqZw+BLbAT3S9l7GmGUZfJu/inLJhpuLayWP9C/l9Yu3TqvkkU5EDMvNB+imStz
    LD5bNG//weoa6AalgfxCtHrOnDrF4BTWyWAzdRQcr7h6sg4jJhwCAQPenrWI4ypm2kVYBj
    X8ftVGCUvap242LwwVJmrN8L9tK1WiVPbXm/7a68Cx5xnPJHr7bN5P/Pi5Iw
X-ME-Proxy: <xmx:qS77aoRom6nyZV66Z3wPg6oRWVsaarr1RrDZkWyZfpNZex20jyTFDA>
    <xmx:qS77ahNmWPcZaIaUPZKVhXyttqDjUjyU5b_L34ifUR5rg06QgVZGCA>
    <xmx:qS77apWbx9cxkug0OzDnIk-GNaxafyFoGjvJpkluXM5AAe-KTbfKFQ>
    <xmx:qS77agcDTvQa_mJHjG1M27m-_UowaxN7u_zyJTq560Mz1nsoNQaq0w>
    <xmx:qS77atsmdpsa1go5rLPrkZ5LZiW0KwT_-EVvzVC6_uumvG3smHhUJOaA>
Feedback-ID: ia3204a8f:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id D47882F8005B; Mon, 16 Nov 2026 11:26:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 16 Nov 2026 17:25:41 +0100
From: "Imre Kaloz" <kaloz@kernel.org>
To: stable@vger.kernel.org
Cc: "Heiner Kallweit" <hkallweit1@gmail.com>, nic_swsd@realtek.com,
 netdev@vger.kernel.org
Message-Id: <603215d0-9331-40db-95ec-5742146a1cf1@app.fastmail.com>
Subject: Request for 6.12.y: r8169 RTL8126 ALDPS fix 4af2f60bf737
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Please apply to 6.12.y:

  commit 4af2f60bf7378bd5c92b15a528d8c6c7d02bed6c
  r8169: align RTL8125/RTL8126 PHY config with vendor driver

On RTL8126A, 6.12.y leaves ALDPS enabled. After the link partner had
been down for 30 or 60 s, the link came back up at 5000/Full but no
frames passed in either direction until the link went down again.

The commit adds the rtl8125_legacy_force_mode() and
rtl8168g_disable_aldps() calls to RTL8126A, which RTL8125D already has
in 6.12.y, and calls rtl8168g_enable_gphy_10m() on RTL8125D and
RTL8126A. On RTL8125B it replaces an identical open-coded write with
rtl8168g_enable_gphy_10m(). It was not tagged for stable.

It applies cleanly to v6.12.116. With it applied, the RTL8126A link
passes traffic after the partner's link was down for 30, 60 and 120 s;
without it, a 30 s or 60 s down leaves the link dead.

6.13 and later contain the commit, and older stable series have no
RTL8126 support, so only 6.12.y needs it.

Tested-by: Imre Kaloz <kaloz@kernel.org> # RTL8126A


Thanks,
Imre
