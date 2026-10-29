Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269307;
	b=Vw+V0Zw4OxLXZLIe8XllEDxOSyB6yimaPhsXpHQlh00cKtUEG40dvyGyFb7loZeMHFa8
	 /ucFtmDzu/+hxvhEbXCocM6Vt0ZxGzfv4sYgP5KUeAW2Xn84V9XdknPSr8sSzopuAi2wn
	 ouZNejOpIVLGuSKPWCrHUA+GVuD0E2ucVMQ37Do2ntSamchfnW3pjykWrhpFzv1/E8LjU
	 cHm8utMLONOCTt2IQj/0c+6VEDUJriB68qmRSxV8gWTKammmfPkncCUOAGN6WRdd3NaMV
	 71vxalV0JZpECOXyfhvaAqgcGKa4GmPdWMhJsSzOTkWePONiIL0oainQxQcwVQvYpwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269307;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=p4CsFDjPOd5dzP69uoDvcx2oKYWrFhACnk9N0TgFakE=;
	b=limdZ1ZwwtambwNfWkQqVLjtv1QA/9pzRFX30D8pYw8j1+pL3trO4wH50FeWQf6+ReNd
	 dWwcmrFqekNoD1VvD5vn0JMgnET+6YMEIl33gkRKGETPJ23S09qQVnTIJzk2DE4rVukcg
	 1r+/DzKLZpU3TX5K6N6TTZnPtGTGdrleHeakLYxw+n5WIwv2X4bs0moCKqGqeOU/e972Q
	 Jy/o6D/URORUMSkOQrjEg/ZOAKFs6P0e1qYC8gVMtQ1QLQX9+/LYCI60AHS56cqMDjuPb
	 X80/CvsmSoX4iOKvuaZVyQQw5ubYTqkfG1mih+U0uKmCL3maCshxZqTQUXufsUyIwzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bYEkEP0d;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C4B606A31E
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08C4B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bYEkEP0d
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15dd124bbe7so3615350c88.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 03:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793269301; x=1793874101; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p4CsFDjPOd5dzP69uoDvcx2oKYWrFhACnk9N0TgFakE=;
        b=bYEkEP0dNxlhTdG9foSUPIsWMX1MtvqNyYtlLTMcLbRq0lyy2cratV0BIr2gtYu5ia
         H4zg9Ixd+52wVE1IOa1nwYwk0JaaaTVOGzCRbxdtp8UMWRBohoa59HBAkTPnVp6UCjYG
         MM5tpk3Qrmw+LDihNTctddLyIJcWuFt153NjbOak20ztDLbLw8MGv7Ayc/Ncpd/eY3Q5
         g7OrNaKPat6T4uqBs/NJ5x4Js0oTp1QyHZlkxvIILTsOo9tvGe6YYKzHiuNHZC8yKsKC
         JClp1ejGPTY4+BGdjE4Jd4Kl1RXPXXteK7SPhdDpfqTYVwJuMrAI5HkWguqSUZ37URHf
         datQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793269301; x=1793874101;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p4CsFDjPOd5dzP69uoDvcx2oKYWrFhACnk9N0TgFakE=;
        b=VNi/NGfTuUzdknVrhltGTBIniM8Hp7m074EUyvmsNsJiTs8T7PKpACxQdwT6OOY3E2
         vVAu7N0emMlvxhVXH4KMr7tcXzQMvMg7CR0N25g+lQ8LqX4vAzmlhEO4uTRzSDIy8l1I
         5X7yy8viuEKMLT9kCU9pGwR/XR+hM8vk0S1ZVaeTaLhIcCovK/QosowrgISqLlXzdnXe
         p+vhE2Mf7B2K/jpibSdeNFbppwzYT8jlcb05UDJznBP6vdZy+521a/ApN6e3MA/neZW7
         dbGGcHsZ/NufKSq+91iIKebyBOZlfkDYdeuCJXqv5ohozlazrW2QBr9fINzSclzyDSRE
         atEA==
X-Forwarded-Encrypted: i=1; AKwUvBzEX56U8aWLvKIBMRoW+vt3DpD2VaWAE5VKzIv0l6bBLQLcH5FsNwnsmtrtN55Fl/ln7EUMYJU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfg/YaCJlK2GQt9akMD05RsLj7eEmRr4c/tApR8NKXap5M4aJF
	S48QAIBhNvBsp4P8fgi11AWAkHlyt/F2TPl2PbmYnhnRZcrI5tY8pc1QHfObKWVH
X-Gm-Gg: AYBFou03KiwIyolkK24uD2kjJygAb1Z3RN2Aequt9ILGPlD0yoQpNDHIc1I+Tpr1euV
	djbLM1UAvZscPCn+2udmHR3P1uY1HMlk2uWD/wxpfEBLN8lK/zHtX4Tqp9dhw0oNFzizsfAKQ3h
	sQloGdu2tevR5oXGjjaoHj6vjqA1CMRBxc6xLt98eQrSZ5oV/RZ6HHE5sWjWK41SD5K2+xQu3+K
	ZqYTSH/xuUyH1P91hdmkmUhmJ+6TOdO4MnO7nnuXo4CCWbrYYa2AjP/i4yvygzqbEEkApVcLPC6
	mO17QidFbW0Qhy636FFeadRWyeeuTyg0NB8m/mXtWPD0W9c051FJ2seD92VY/g8mv1SAkZQAS0p
	aIIeIIEAkTAptMDC8VxBce7zizVyCt4EGc1opKCKnA9UIYlSaBtLt8efTD47xd8N2+lI1I8+v7N
	pszJ2b0O/TUL+CbsVVVtiMcTTwJLkI+XoT/rgG/ozMhEECNvKTUwc6YyU6pGWulSdQUoQPMQ0L3
	fEt5xPoGUNVTPuFXa1jQJs8QOGSZ9KREuY3790FqdnXmSBO8cSC0Vs4r3gj7MMm8GQWUHpRXwFc
	TwMBaZ1oR9kzr4zyR1TaDKgsIIYPjr1w7eMGnzMGXMj1QlePcgl27MAuuU0NY3DIzI0=
X-Received: by 2002:a05:701b:4211:10b0:18c:ad6d:b790 with SMTP id a92af1059eb24-1a6cf914593mr7053743c88.45.1793269300875;
        Thu, 29 Oct 2026 03:21:40 -0700 (PDT)
Received: from smtpclient.apple (v133-18-180-162.vir.kagoya.net. [133.18.180.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75d76814bsm13556801c88.10.2026.10.29.03.21.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 03:21:40 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH net 2/2] Revert "net: advertise TCP MSS from the
 configured MTU, not the learned PMTU"
From: Esko Mobius <echoowall@gmail.com>
In-Reply-To: <20261029101859.6893f1a0@pumpkin>
Date: Thu, 29 Oct 2026 18:21:22 +0800
Cc: netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>,
 Shuah Khan <shuah@kernel.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 regressions@lists.linux.dev,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 Eric Dumazet <edumazet@kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <22077B76-12B0-4DD6-813E-A3968003575F@gmail.com>
References: <20261026-advmss-revert-v1-0-272fa4b7ecb6@gmail.com>
 <20261026-advmss-revert-v1-2-272fa4b7ecb6@gmail.com>
 <20261029101859.6893f1a0@pumpkin>
To: David Laight <david.laight.linux@gmail.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)

On Thu, 29 Oct 2026, David Laight wrote:
> If it isn't a silly question, how to connections in the other direction
> work?
>
> I'd have thought they'd need that ICMP message to get through.

Not silly at all. The frag-needed always goes back to whoever sent the
oversized packet, and only the client side filters inbound ICMP.

Server -> client (downloads): the server's full-size segment hits the
1456 hop, the router there sends frag-needed back to the server, which
accepts it, learns the PMTU and resends smaller segments. The server's
send side was never changed by 2640e6419594 (tcp_current_mss() still
uses the learned PMTU), so downloads always worked.

Client -> server (uploads): the client's full-size segment hits the same
hop, the frag-needed goes back towards the client (via the relay's
conntrack), and the client-side firewall drops it. The client never
learns to send smaller segments, so the upload stalls. Here the only
thing that kept segments small was the smaller MSS the server
advertised in its SYN-ACK, which is what the reverted commit removed.

Thanks,
Yongjian

