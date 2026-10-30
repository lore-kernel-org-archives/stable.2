Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.75.76.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793376665;
	b=YFLG+xtPGq/qn3/9SKaek9scyr+RxTX18JbftwRID1+OB1JJ7fl0Hn0IOTjD0jgBTe8R
	 UFpcJchyoYE81wdlGnkzcEkvVvttR8wgU5784dtexSdVb0eq6/3k/hUoUMTT/HkDTBbax
	 mYxFWIzdIlxKSesMfSvDuB3hv7ZhPKgEY4bhLynBJc9WmekkTF6bMCeXhDjCBr/QhvSkq
	 A4URl0HSSFwtd2nO7v9OYSnXt8tFNKAGj6SYY27pjW8gSukxG1nptsMC+KNTlzz1XQ1FI
	 iTaGzRE0Ttcy/8TDOywygV8ehsIwoRli3SWiHj39mLp680IFoq3UWYo/amN+faqZ6/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376665;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc:Subject:
	 In-Reply-To:References;
	bh=BIK4o9voq1s9DeirY46KYylhiXNUETUHwFnaFf27cO0=;
	b=w+A0YLjwAIxRHASeKKp/rubdLu3/0etwxB3sTho1O6qrPnZO9YF0+eRJSWiw816b8fRz
	 0cNED9xSG3nO9S85Y5H0vn21Hkk77QNjgjYITudlHPq3uWLKNAW2UlWYxUghofv8QjhuV
	 YpqljIiOIKP4Ya1LAgkzlZoqT0WewChiSXoBqWSsBliuRp5AMeGJOoqmZEGdhUoEOBurn
	 LGE1U7nGKrxc5OOX9Tx1Npptwcu7yBkCuQen35PmqYHstQ8jYgUmVTkC2RezoLn2/fo23
	 rnIxDuZ4X5eaTjuMu0SVG3wCi83vI17lqtcdd5OmigSthY+v91RDpseTqNpwUbffnRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=podgorny.cz;
	spf=pass smtp.mailfrom=podgorny.cz;
	dkim=pass header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=U8B8+Cre;
	arc=none smtp.remote-ip=77.75.76.89
Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.76.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53607606A31A;
	Fri, 30 Oct 2026 16:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53607606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=U8B8+Cre
Received: from email.seznam.cz
	by smtpc-mxb-64995d6b58-wb7nk
	(smtpc-mxb-64995d6b58-wb7nk [2a02:598:128:8a00::1000:929])
	id 03bf85b1b58528a806309ff9;
	Fri, 30 Oct 2026 17:10:32 +0100 (CET)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=podgorny.cz; s=szn1;
	t=1793376632; bh=BIK4o9voq1s9DeirY46KYylhiXNUETUHwFnaFf27cO0=;
	h=From:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Subject;
	b=U8B8+CreJLaalV4qVT2A/oiUASFBTSRLyjkmOl4MZwMaBEwSHHj46CAqwjJQbbvpX
	 BdG12W7snQW5ueoH6XwSy98wrfmzMuotr5GkW+f7ZYdEQQSGU2lfwlO+JEG/lU8gEO
	 tfcoo87LlByYZO95hRe+HND/teOTPnLoPl/mY/Q+ZdWeTkzdat12veiVS3qiKujunE
	 hbwj6onU1TKdSXnWZkxhIWIDlHOSBTZjKGYQwe1MEAClp5Sg6YzpNZy/S/K8CGPuHG
	 JPPeiX1AI/pytPa1XFEa48zLjQxMGap0v5LzEV5+rwFEwlH87GqKsTxCXVouRU6pTz
	 zJSf3S1Qs4jKg==
Received: from [192.168.31.81] ([2a01:9422:904:1ee:272:eeff:feab:4ab4])
	by smtpd-relay-7df688cd44-x4dtq (szn-email-smtpd/2.0.89) with ESMTPA
	id 8662a0eb-1952-44ba-b783-0a7de3715fb1;
	Fri, 30 Oct 2026 17:10:15 +0100
From: Radek Podgorny <radek@podgorny.cz>
Date: Fri, 30 Oct 2026 17:10:13 +0100
Message-ID: <179337661340.2790793.10493980332574129560@podgorny.cz>
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
    Marcel Holtmann <marcel@holtmann.org>,
    linux-bluetooth@vger.kernel.org,
    stable@vger.kernel.org,
    Sasha Levin <sashal@kernel.org>
Subject: Re: 7.2.y took the on-air address fix without its companion
In-Reply-To: <2026100356-magnitude-esquire-89fc@gregkh>
References: <179097754519.501890.1801734138080126989@podgorny.cz>
 <2026100356-magnitude-esquire-89fc@gregkh>

Hi Greg,

Sorry for quoting a bluetooth-next hash last time.

The commit is now in Linus's tree:

  3889a5fcd091d2154861c19e9c581f9f04aabd0e
  ("Bluetooth: forget a peer's RPA once it advertises its identity address")

Please queue it for 7.3.y and 7.2.y. Both already carry the on-air patch
that needs it, and it applies cleanly to both.

Thanks,
Radek
