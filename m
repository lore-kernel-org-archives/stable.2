Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793277412;
	b=5LJUviqjzJfYi0shMtRxMopznvioA00vD/nq7UjdzQNB1ORZoTWtYIE07JR/qWPXSp+Y
	 uWqjHtH683tOu9UpDfUClce+9ivdeRVrVXEMJnzxw6p7Sf+XQWTD6s+CmUh8CIHmLmRBa
	 qmm/kk4YB+pcmNsRpgn7a4MwTUghQzNezmJzCQmlPL/zaXLrfcLITMbhzJOTeR8VAEflZ
	 /TNBa6V6pmU7STpvEXzboEuZyDA4ebkdL4rb+u2b9j0EaJKGDlhL218hq7IR5KI00yttm
	 2SpL/hTeUy0kZDwnfeMzn2UKC7anW36YqAix1einjGs69HvMIPXb0amhv15h1sCqoQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=hmc/RolTYy7SeBRxKLMjWzilnvA83GevNb7ysMoswG4=;
	b=gljAn1PjpHOtSuDxxJSmZ9tDyhaYow3+XyLeKXSMEGg0We7P6PRoyJVxN7HR9KL7Z4Jg
	 2Xcnb9T9IuCGeXN+z9/QgLHR9fpE4gVMgKcV13uhu4THym2M+ehDs+G5GRbhYHJBFEu85
	 rOPL9K/XzenlDKejtvohSGCI45/GBQw+S1sjJboAxHMwvoV0PE2RWzHN2BkjQvFMH1yh1
	 H7IbOivARqYxAfhxpvzAh43jY1b6+tRjatbMxLJIw0GMYwcnuM2StK0VtHSbh5NrUlTAT
	 6a3n7qIwtPdDQDDDHKp1jYwaePNTlWsU7Q27KePVIReFnooxBIZevsDz6U/9ZbkahOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=py2QzJFY;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F3B60A260C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 12:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58F3B60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=py2QzJFY
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a07078200fso1066567b3a.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 05:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793277412; x=1793882212; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hmc/RolTYy7SeBRxKLMjWzilnvA83GevNb7ysMoswG4=;
        b=py2QzJFYgzOL03zGd3mHO2Bdili8XEZjmTBrfP3m4bXJAzbCdzUnE14wPgfXIR/hKe
         zAtdXpeTk/pgITkJricxOBeRqKkncsIhziwOUNdrF4Nqw//AZxy2uVu7JyYGMeJN48FI
         trZb0Im4c61Mqbor7x1XbyPT/JT2OH8M5BqYP2ShvyUEiWtu4h1h61NvSmb2oPk3XWUd
         KqfWHqesgeqXa/Qhksfi1BxV9idSCShFWKVwLAy8e2qHEm31JHs9zkkyVIImFi5Wd/Im
         UdHQmnMvZb/drJfythss4ld8cwQ/Q9/+VxqcJUUWbduiCALdGR9aa08Psyv3dV11sL4J
         uoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793277412; x=1793882212;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hmc/RolTYy7SeBRxKLMjWzilnvA83GevNb7ysMoswG4=;
        b=tfRO12KGMKtF2v+vGJtDFK3OS/mcbJsSi6LlAJLx0b8r7GzD35VE1qsMonaQ66fMXz
         JlSvki3lAbCbbC4ff4inolNAkNp4SM2lLA3gQ0mDGN56sccxbfdq8PGIdjxoNgtUIv7g
         chZm2HG0EBb2KqWEYODCiVQgO+eMSC/rO3wSL4U8iSKRuap/TFKb0iwSNowDv3bfArVN
         46yn7dgqIaT6w3AC2y7qotl9IzUCunlv7Hjel/1VaKATNDhNiNK3LNM7LdyfbROYOuO2
         RIF6bczYU85RJGqW6f2/bpYqMldt0MIpGlFn7FVRuq6HgsTMercpjGT+cRupAA1kWtZE
         KolA==
X-Forwarded-Encrypted: i=1; AKwUvBxIOJPVmP6iLxmid0OtGw+cpyJ/7CjmP24xpKmepU1pX4VILCruoIWyMuyFkxYzbKPcseociWU=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/NsloDY8ZQY1SD5uhzEzWDsN+Yjg5zx9WC/uvkZxBTfKwq7cq
	BlRQT9lznDLAx251GYdGoDgvNbnkGXJ0I9xlTdHIIaSu2h6NDGz4aGQl
X-Gm-Gg: AYBFou33QIPHrWT3GtcdxLUjbczP4nV9BLXAvBT0mCihzyp5ODfkf5xZcJGpBy/M56d
	J0MWkn5yD/F/AI+sFbY47cDVVTdT+BbKS8vFmzeDYMbJiE0S7OIF03ZMTgeu8gBrptRh58IsA70
	hYThhP4LGabq9Smz4ZbMbHGXfRnJgqIJlVM7A2fVePeGRd3k88Nm2UBDRB70PzpLRgYA5hk2Zf6
	BhLblMO2b6qP5NpOEMDHBYbvJluyw7Q9SNVHiLBZwx3vk5jsF/W+czfyLqObaRqMOrd6o+ugkf6
	Zbx/yocm1cx2r7u/8oQHCLfEv1kvjZclQWR45libfHRUJvngiqRu0V7rLgKgHWXkq8qOLRxDpUc
	KiMzZgRZqP2nOfh/afhG3xCTdzx8dSWgWChq9efpil0Hv/QQgB7cK8qp45Bxtu/BbUiJQ9vb6sP
	rHPjJ3yTRtCaTMrHOCb9zUNGztIwJuAa62dst+z6FoBWdjG+6AUMM95AfQ7I06/7XTVUFKi6Buh
	zhJ/45zMD/ERq1tz8sQQI2idsoyzsGgbce1BU2Gr2LMl+z3FvVdB2M9kpftVFoXelk7O+qTizll
	5N/CKgynqbbNz0qLfS8tDGqnO7HS22I1oMcU8Jwtsh9eQZYYloCMoR21QHcDNuowLR8=
X-Received: by 2002:a05:6a21:8804:b0:3e2:97ac:274e with SMTP id adf61e73a8af0-3e9023ed955mr3933798637.65.1793277411671;
        Thu, 29 Oct 2026 05:36:51 -0700 (PDT)
Received: from smtpclient.apple (v133-18-180-162.vir.kagoya.net. [133.18.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc46482sm5225375a12.11.2026.10.29.05.36.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 05:36:51 -0700 (PDT)
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
In-Reply-To: <20261029112045.5e7d4317@pumpkin>
Date: Thu, 29 Oct 2026 20:36:33 +0800
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
Message-Id: <40993B2C-6390-4BC6-B4AD-967518B0CBE9@gmail.com>
References: <20261026-advmss-revert-v1-0-272fa4b7ecb6@gmail.com>
 <20261026-advmss-revert-v1-2-272fa4b7ecb6@gmail.com>
 <20261029101859.6893f1a0@pumpkin>
 <22077B76-12B0-4DD6-813E-A3968003575F@gmail.com>
 <20261029112045.5e7d4317@pumpkin>
To: David Laight <david.laight.linux@gmail.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)

On Thu, 29 Oct 2026, David Laight wrote:
> But that relies on something having gone the other way first.
> In general that won't be true.

Agreed, that is the same point Jiayuan made.

> It is almost worth implement something that retries with the shorter mtu
> to detect the PPPoE mtu blackhole at the sending end.

Linux already has this: net.ipv4.tcp_mtu_probing (RFC 4821). With it
set to 1, once the retransmission timeouts reach tcp_retries1 the
connection drops to tcp_base_mss and probes up from there. It is off
by default, and the same goes for Windows (EnablePMTUBHDetect); macOS
turns it on by default.

> Or even just use the shorter mtu for long RTT connections.

Both of these have to happen at the sending end, which in my case is
the client (it is an upload), so the server can't help. The only lever
the server has is the MSS it advertises in the SYN-ACK, and it has no
RTT sample at that point. For now the MSS is clamped on the path.

While reading this code I noticed there are no selftests for the black
hole detection or for MTU probing. I'd like to add packetdrill tests
for both once net-next reopens.

Thanks,
Yongjian
