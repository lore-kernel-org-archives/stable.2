Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFF839CCF0;
	Sat,  3 Oct 2026 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791067062; cv=none; b=Z/rFggsXPVwENK714xU5U+Pnrq1CVQvQfJJ+bZvW/Jx/6l3bFzJKSIKg97vspL8gMgbhNYyUewbFBALLcHIkZ84y9V9eiZVZNFhDZS1JLr9eAPgLT8gVdV0nsTHxttt9O/eW50AlPAAzGqI3zcfiKFEnnP9Vk2XrsHaH7JEWY6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791067062; c=relaxed/simple;
	bh=K8umoEkhTdXmg0n5vNJisP96WiTzw4rrwR+ixiCbgxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H67CGm92d5vD2xn/xE0JstyTaioezLdS6yrsLRsAYVv0vaK9hJefJVwBwW+erC7hQIBWZbHH1M6D0jrNICJSLiA0oUIM6Y3SNshURxQcdx2yX6JPXWC54kN3k8gsrm1bN67PtnqfdV3g/hyBUI/q/9brp/LtfTBA1QQNtai3HaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lw7Nj/jB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lw7Nj/jB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D38B1F0089B;
	Sat,  3 Oct 2026 22:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791067061;
	bh=I0XlnC/1RJNgNAAz/Z4eGRmTMGyKRo+llzCYMpPefWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lw7Nj/jBmhxdhASagSPhHbC8bW5+s4Ofwsw+mfa6sUugT7ZIxDtt5BCdg+IX9gzSh
	 vNxm2DgeTXV7ROfY1Z/kCXGyqUZbdIFskFasr+J9okNDTyXXLTXCspbPFx09DtVDTE
	 +32ZJhy/DxNJTthcmVtca6GTmcPNm2wOUdP6pKtXcuPVe3IJVoSJdiM2ItsopYLUec
	 Cuf1adGPV7qsyg8tNrdXrhI6PDSzOLfgkeaslbDWvOBsAT5v3TZmuoDNwUfLG6h+5c
	 ugbo4FB3vyqbRDPGRCzV224dpdOWaI8QZGXs7kll1nfMzCUYq3JBpLB6IMK2e7G+q4
	 RY9nd7eTimLng==
From: Sasha Levin <sashal@kernel.org>
To: jungwon park <jwpark@whitecode.co.kr>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	gnault@redhat.com,
	netdev@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.1 000/982] 6.1.189-rc1 review
Date: Sat,  3 Oct 2026 18:33:00 -0400
Message-ID: <2026-10-03-1-daily-reply-0019-re-vxlan-wrong-patch-dropped-6-1-5-15-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100245-diffused-handball-90e8@gregkh>
References: <a1a0f247-e847-4598-9b84-9840ddbf50b4@whitecode.co.kr> <0f382474-d85d-4736-8ee8-e934a96ae2d2@whitecode.co.kr> <2026100245-diffused-handball-90e8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > This appears to be caused by the patch titled "vxlan: Pull inner IP header
> > in vxlan_xmit_one()" - 667b5d5945e8947868fef8d75bf3ce4accb81b30.
>
> Thanks, I'll go drop this from 6.1.y, 5.15.y, and 5.10.y

The drop took out the wrong vxlan patch. "vxlan: Pull inner IP header in
vxlan_xmit_one()" was already out of the 6.1 queue (I dropped it on 10-01,
after rc1 was cut) and was never queued for 5.15 or 5.10.

What came out of 6.1, 5.15 and 5.10 instead was 481506a756dc ("vxlan: use one
headroom snapshot for neighbour replies"). It only touches vxlan_na_create()
and fixes a KASAN-confirmed out-of-bounds write there, so it can't cause the
dropped packets reported here. I've re-queued it for 6.1, 5.15 and 5.10.

-- 
Thanks,
Sasha
