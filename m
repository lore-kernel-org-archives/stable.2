Received: from mail.whitecode.co.kr (mail.whitecode.co.kr [211.63.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D7E34F48F;
	Fri,  2 Oct 2026 05:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.63.65.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790918214; cv=none; b=TYO1HZOAEydNURRbAbYiENjiLzgny4bNBQ0qsIY9sKfWLEoJWgDdDMUPoimt9DmQSjCu2fv0reyx5lm3NUhTXJNesNfiF31KJcfg2ELSfWBGdKhd789+kAYJmmyQrauA+3XcjQ6Q+/2gkHzXByQ2uuLMH4yNd8fJzKlRrtz1m78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790918214; c=relaxed/simple;
	bh=V2j2TtUWNe/geuIqPZkjOF6f2051Ssxlb8fjTI1i0X4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qQLCxfFg3/NlIaU/bnhie8ScUTVL2qwyk19dFTY0tXccvoHitnjt29dERMQwBL3Kp92GKHxio60HVSbNEGKWqvZ8mfeQ/y0LkR0nuKc8wWKD6lP1U2RTLQmzVQ1tb6XqIpQ1ZnqZniAwem1slO6kGckhdUk52yzW2k1uvulgbN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=whitecode.co.kr; spf=pass smtp.mailfrom=whitecode.co.kr; arc=none smtp.client-ip=211.63.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=whitecode.co.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whitecode.co.kr
Received: from [210.16.232.11] (unknown [210.16.232.11])
	by mail.whitecode.co.kr (Postfix) with ESMTPSA id 76A04401DB6A9;
	Fri,  2 Oct 2026 14:16:51 +0900 (KST)
Message-ID: <0f382474-d85d-4736-8ee8-e934a96ae2d2@whitecode.co.kr>
Date: Fri, 2 Oct 2026 14:16:50 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/982] 6.1.189-rc1 review
Content-Language: ko
From: jungwon park <jwpark@whitecode.co.kr>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, gnault@redhat.com, netdev@vger.kernel.org
References: <a1a0f247-e847-4598-9b84-9840ddbf50b4@whitecode.co.kr>
In-Reply-To: <a1a0f247-e847-4598-9b84-9840ddbf50b4@whitecode.co.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

 > This is the start of the stable review cycle for the 6.1.189 release.
 > There are 982 patches in this series, all will be posted as a response
 > to this one.  If anyone has any issues with these being applied, please
 > let me know.
 >
 > Responses should be made by Fri, 02 Oct 2026 15:23:04 +0000.
 > Anything received after that time might be too late.
 >
 > The whole patch series can be found in one patch at:
 > 
  https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.189-rc1.gz
 > or in the git tree and branch at:
 > 
  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git 
linux-6.1.y
 > and the diffstat can be found below.
 >
 > thanks,
 >
 > greg k-h

Hi!

VXLAN stops working after applying patch-6.1.189-rc1.

all VXLAN packets are dropped (only the "dropped" counter keeps increasing).
This appears to be caused by the patch titled "vxlan: Pull inner IP 
header in vxlan_xmit_one()" - 667b5d5945e8947868fef8d75bf3ce4accb81b30.

It seems likely that this patch was written before the change to 
skb_vlan_inet_prepare() (net: tunnel: make skb_vlan_inet_prepare() 
return drop reasons) was implemented - 
6dedc8c2a4bfc64ef07410634e944c0506eb98c1).

Best regards,

Jungwon
