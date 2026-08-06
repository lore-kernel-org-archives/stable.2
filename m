Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299A346E01C
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016206; cv=none; b=hFo71lBmSXjYKB59mDb+7MyazVs8cHEwDAhMuyuq9YYEAK6mUCaAgjvYc7jPr2SGRKJfQzH5SXqZVgJKFknUt2oSj/p+a1VFuJUYQzQd4EoKwqW9EKs60KquERwlo17sGabLVmi2XNw2yTPWFLx23JaUfbajF6XLUxBsgGOn1XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016206; c=relaxed/simple;
	bh=YLAqWdyxvsFqzD0JuU58c2v9kEulKJVZWj3NRf/VKhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+Af34FMUcUvFMYL1EGk7Fxo5Kwz1To1zQu2cl3aKBlZxrWpnSvP8vrXHr5KbnD040vDvBvTTNxAPkkt5YpfaoXkLv9NErJ7u7zFlwRAl0moUGPMoRf1V8rCgr+bYIBJqz5V1/SJ0w95AS4uP4Henwe1BSl1S7RSnsFoxmhquxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzFSOqOJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzFSOqOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4501F00A3D;
	Thu,  6 Aug 2026 11:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016200;
	bh=rTWlNMnfjcgRSkGXoHhOIEmR/Vx7n8khf6XxsW8I9X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OzFSOqOJ4zd+hqoRa7pHExtvmxG7J+NTzJPWh4rN3xOMyK52C7UFi7rmhwy6J9wOA
	 dwrWHAWUFA+TPIjItendv0E2Vuyo59SLEbKcFeYavL+SRFL7GFwsyo/a1KGgfGwgfa
	 zMdt9npUVzDdc1TSHaFOhl64kbOc1QpFntDSTn2maiRMmcULWo4RyLvAURbx1OMdr8
	 ou7WgdhXfMmZ7zRcLFmBWlbjWxff5nb3zy08w0T5/hWCNGo28iEMiax+nXRkpaFS8g
	 n6mJ6G+0tCsj6TQWFbta1bpRCVCyipU8lm8kc//7fgcjEPIi2heoSl9038QUVt9qkF
	 oe7odT6xFHrRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5.10.y] net: openvswitch: fix skb leak on flow key update failure during recirculation
Date: Thu,  6 Aug 2026 07:36:10 -0400
Message-ID: <20260806021809.0017-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805222104.2820621-1-i.maximets@ovn.org>
References: <20260805222104.2820621-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 06, 2026 at 12:21:01AM +0200, Ilya Maximets wrote:
> [OVS drop reasons are not available in 5.10, hence plain kfree_skb()]

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
