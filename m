Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571409;
	b=G6KE+CrTCeubNLqfV/14/sDPEtgf0FB4K7+PXXMeWZ1MgeCZBYRXqFdpzdWrlVfQAip1
	 FyHh3uRr4MaI5Lr2KVnnkRCsv6OzREMCaYhxbQIMfpT+Z6M//oZzCAAQT9r22D40khpdm
	 PhLD4d4Elyx48KEQJHU5ha7eXCBGL5rZ2wqEqAjWluXDcd8RmDa9Yvt4m8AOp894S5iyk
	 SI1hNqb6tbIodojK0ZTRu48n4HajbS3FiFEGML7ZizimfgJRobf6yaT31WwN2lE0NnSQe
	 NBoViHYJJDdNceKBpXkjB/++XC+al65W56prkvLYzR8VodMfba9IcpPM1XK/uhlh+2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571409;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ki2tW3P/WLw9hD2gIz/rvc9LDBcAyijfa3p7DBWWlo8=;
	b=LMpzXVbaaj1jRCt3kbNHGRy8eRA+3kCgwzqCKoT2q62qbc2Dn4AbUgXh/d0dMRp7uEkP
	 Mqk0OCYXkJu8iC3ynDr5sKQAAs4MSrxdovs/hwCUV/csojXx5TjesPrENRqxLEbcU+pRQ
	 IbiOktRdoCvoRgyzgNlCtt4pXEBjDQvozs2IHXUr0CnvqGWBSWL5mvndXOT1eWa6TH3Yc
	 7zcZIvFww8kdl9A1ihfydy+FCB2dEcS7xJHufURGJxxKuI0Of0WIWiNZitYtYB7YXwLmr
	 72+MwofbcbM8pUx8cKkLXpCf4qEIbtniZzT5XwEnsLfqwTe2/6FiL45C7cEPUTeSSWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=J37+YtqQ;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96746607184A;
	Sun,  1 Nov 2026 22:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96746607184A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=J37+YtqQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=ki2tW3P/WLw9hD2gIz/rvc9LDBcAyijfa3p7DBWWlo8=; b=J37+YtqQ/0d40Z4gCY5hvQOk8e
	oOMbRz5pmBf5TnhA1Bh85mB6/DJVLMfn8SuicpDqMpeDDl1ANaqTniuGKAIieI8I4LCYheCLlps1b
	qj1Qeo6mzg6K4WLOMMaf8hbQgkdLAqXzHZINj0bLIDBGhExq3+AIuKudZilMCsqVZ5shYWqm8m80r
	SkH9NeDnSRidUXcJ5QYmfK7jM8CFp1Okihhkk6eryhnrmDUF8DABgHVoWQyjaMnu/ynZvDn3F2aDp
	9XAKBpp5QvHBXX47G9hg89M9n64tHxnm8obpLjZn7IR6r3L/p8rvJ0NxXFf+VIPtg6QIjtX8jmHno
	Nrz0Qi+A==;
From: Heiko Stuebner <heiko@sntech.de>
To: Stephen Boyd <sboyd@kernel.org>,
	Yibo Tan <lhfff@tju.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] clk: rockchip: Unregister notifier on multi-PLL registration failure
Date: Sun,  1 Nov 2026 23:16:33 +0100
Message-ID: <179357139337.4108484.9561069147699443537.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919163106.1833104-1-lhfff@tju.edu.cn>
References: <20260919163106.1833104-1-lhfff@tju.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 20 Sep 2026 00:31:06 +0800, Yibo Tan wrote:
> rockchip_clk_register_cpuclk_multi_pll() registers an embedded notifier
> block before duplicating the rate table. If that allocation fails, the
> error path frees the notifier owner and unregisters the watched composite
> clock without removing the notifier.
> 
> The common clock framework retains both pointers in its global notifier
> state. A later rate change walks that state in __clk_notify() and reads the
> freed watched struct clk before it can compare the clock core. The notifier
> chain also retains the notifier block embedded in the freed cpuclk.
> 
> [...]

Applied, thanks!

[1/1] clk: rockchip: Unregister notifier on multi-PLL registration failure
      commit: acee45f349c701d29e2753227b813cd692fd8bda

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
