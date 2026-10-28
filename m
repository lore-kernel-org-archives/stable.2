Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158725;
	b=cC7ngvLW0A3ifbkmeP0p22aFMXlPILwhmJDx7td35bDLVHWd5rpDuLlGzknPce3m14Ux
	 li1RECh3SP+0BEkXuHprNfhEe2UcGiX+XaoLDx394BYDZjGKBmFePwbX16Wo/NhetbOe3
	 2BndJecsJryCIy29xvMaz29bZqGvGtK6rFwCs7hxWHCMZGNincXLBhBIeXDEMMqgYbNad
	 FoI/fC4sa66XtugRX3hCEbovIe5UeQF0aD57Q+rEKMYfy1j9r8mXEDbSPRZYcrCXOgsXU
	 BbpfvuylZLK/Fg93ev0Ju4jAA3I3xbRxlr6+vrUzJ1IxguLtJnV+6zXHkZIhu1tWh8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=VQJFWsO2O0YbolYW05VDBIkhficw7DwnVaUUdw0UKuM=;
	b=JrX522pH6lRI1IUGIZDAbv+ZbZ+JawFKhq7/JAaeCPHH5PS1P8w84uvwKrpSjIJ/Gy1u
	 6PIk8WV4RS/eBuTIlWwEm3mTtiReR6WZxRBUwkn8O0S9sSrXJV1u2/tIxnA9hfZza295y
	 kAaWwx37/AXpPH75bH/r7K+h2ilkR3AeLVBO+lyAchAKhjUQ5+xbsHIxNpDlY1yyK1kIz
	 ZegRZHM5LudO5/Ed4Y1ILBgJ70Nh039l8LmP9KC7V8G6Az9P06M+WjpjWvZETm1TIh5hY
	 5d4fMl7mNPDvkQm/OfsEx5Qd2J5fDjJ/hepC81NtiXbvZKe0/ty3QdL2Rt6iJQ/Ytkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kpXTMhRh;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8136606A31F
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 03:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8136606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kpXTMhRh
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2eac4877accso1553265ad.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 20:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793158724; x=1793763524; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VQJFWsO2O0YbolYW05VDBIkhficw7DwnVaUUdw0UKuM=;
        b=kpXTMhRhTD0FmK0+Tjl0Em4BWm/lyKJb+frQFOxvez1rlXCx39Mwq++SjA21V0vDEx
         Rsgjc2ofwsAUcM8LYToGox3wv4FFBgo4U5UmA8c73iXaHbkcn05wIsJnE7Nxab5aZQVr
         OBIFEe8rYgqsKEQXvfygKrbJh9S04b1Si1sAadYfYJVEevNDvex+hiYBwSlu6nqWCyaA
         BS5iHOlxoj5z9reaALRU1FXhS17w4BQWqYd4U+6425KuO+rThn4nNkiuERSOFJrnoGLt
         X9WYqaXBlHChn6/K5DMWMT+yz1xqsXP2zwE3pCaptODUD4DUcJ8S7r5ixJXN/gVpXvhF
         Bu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158724; x=1793763524;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VQJFWsO2O0YbolYW05VDBIkhficw7DwnVaUUdw0UKuM=;
        b=xjulyX9PJWWQAEZOwTyRTdwcx5sL9bfKZlVctue7VYuN5GYv9MXGiogpT/LnI+BPtH
         HDIN8/xsxoDeFPMM4+STENTGUiKK1Z8l3FzTiULFsyehSecnr8x1MxUfKkYRxNerY+2Z
         2SsQ4UPH80xEJiU8Km2J2afGJSz306d1aGsJVqJ45OS7bOSruBrryvtE2TrDu0uyvqqz
         gq+hkBrQ56laS1sYVX98ULbUSs2rLRouZxs/tdEAzO76caOqFydBmLVu4RkgA1o8DkzY
         ngIBMisMbpNIlpDtJ8Z+Cvfd0a7p7znfIGXwWZ8bUOsEP/62gD/64PeROfzDcqvVEQp4
         MOqg==
X-Forwarded-Encrypted: i=1; AKwUvBxxw3GDJJXvhl/ofg8L6x3jpD6/CgMtPicfaOgK75B0PlSscV5hnzdIFxMf0EPmIUuYjF+IeC4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2J0drRttjfu8O22Pu3rask0W/CaYR/j6s0tGRe32WlhhsNBO5
	VRXHuWvR5Izn/+4mB2idu0RmoWXzFtdgTfROzGLgBng95JRF+omI3Bt/
X-Gm-Gg: AYBFou3GYlb7UjULRwKdiOsNLuvJC3Gi+Hfa3LqJXgy3rrU3U3SWPsw9oUMrdI4ZjyR
	RQB0/ijdUgBcncqlhP40IrBoMEVuZw0/SxvW8ONzuNycnmhB4c4VKVgxYZOXJatRr6uCxVtkNt2
	cUyekgR8/F0pLbydQTUmop1Kf0rA5Ks/e/KiOoQYGBW4SGDiTmew/cyepwY3uYvMl9FKT3e4IaF
	6LiDcWZuuNuqc0bKkc7MkSNhft97Hz2RaA+w24E/PXEIUnMJ/GAKeEi/2XKZw2AC581o5aRGfFv
	paubOCa0LumHzv0XVf0DaSe7BiHL44E1sRgUuIJQhqdbSYI5hJB0WTA+6kuysnqrjy8vrDfO3BA
	nUXV+yYfBGQ3vDqRjCyuzaVEW2uXny6/oKq9wrRlUJ+lASOQg/RplcSNT/0C33ScWaySjGgf9DJ
	r/oXRs3sp1UP5QzNLdpsQji4575ZEXsuf8T7zQf6IloPcecLsE+S86qsnii3iV2DMnT62hVKQiS
	s379KnKLnaXOSvrF2jk77GUUpu11BsjeiclqKrCbQ7cWXcf9qn9sCvvbdMhsujl4LQ7MJPbRula
	UfJ7ijTxWltSRv3kiHLfp6yTctw1Yevf6ThJTD37yfB7LEbkscjqXJpE3TvDKkBI2oI=
X-Received: by 2002:a17:902:c40e:b0:2e9:8202:5083 with SMTP id d9443c01a7336-2eb0051eb1emr13234255ad.55.1793158723876;
        Tue, 27 Oct 2026 20:38:43 -0700 (PDT)
Received: from smtpclient.apple (v133-18-180-162.vir.kagoya.net. [133.18.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bdde77sm15882685ad.31.2026.10.27.20.38.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 20:38:43 -0700 (PDT)
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
In-Reply-To: <20261027161813.3092f32c@kernel.org>
Date: Wed, 28 Oct 2026 11:38:24 +0800
Cc: netdev@vger.kernel.org,
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
Message-Id: <D0F0DCA1-9CAB-4BB3-92CF-223C9ECA9BF5@gmail.com>
References: <20261026-advmss-revert-v1-0-272fa4b7ecb6@gmail.com>
 <20261026-advmss-revert-v1-2-272fa4b7ecb6@gmail.com>
 <20261027161813.3092f32c@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)

On Wed, 28 Oct 2026, Jakub Kicinski wrote:
> Is this your real name? We need a real names for code contributions.

Sorry, it is not. My real name is Yongjian Wang. If you can fix it up
when applying, please use this identity as the author and sign-off on
both patches (and in the Reported-by of patch 2):

Signed-off-by: Yongjian Wang <echoowall@gmail.com>

Otherwise I am happy to resend a v2 with the corrected identity.

Thanks,
Yongjian

