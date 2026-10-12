Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4333A4A387F;
	Mon, 12 Oct 2026 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821640; cv=none; b=TBziZ5cSx/i0hO1gV+qpfWTW3BhMCKsGdfer/qYu7iFAJi4l1Gm24S8EoMtb2JRuOBFMhU8hUSRWySx1N9Kjy7IE+5U2Vm3Nc7po74Er3t77WLA1RWQYIHjNuCjFAAmB3zFLoIL6tIN8g26R48I32kBWpUZAFY/oyUdmMmXdxUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821640; c=relaxed/simple;
	bh=ZchrZpqtkvDWRfz8meSczFuSA2w/MUsx6xnD2KxnOTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRkyzNm8Ry3kNZzAzrNMwxR374xFWreJTUxji3SqrJ9UUXjcZINjpRbqDJRqSuIHl9Wxt9hM4EXL0OD+HEhFJR+qE0GPmnbFM77f94hpZM01nISAxJvIy5g5kioI64oyChSxxGnd0dGZqfI9LERwP2qw3XKqQC0fpzliuSBvzjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Odp6rZsc; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=qJylqf3c; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Odp6rZsc";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="qJylqf3c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791821637;
	bh=ZchrZpqtkvDWRfz8meSczFuSA2w/MUsx6xnD2KxnOTM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Odp6rZscQ04kuWx8JGESmYnO+ECGUUTzbu2RHovx1TTdovQ7AXDrmvZM2qO5/OO5n
	 weYYsIdeKhGwsYg2J4i/zuCdV74Kj0x85qL//bpNLWZMb5Ffn8dOFhp0L5obiszUoH
	 NnUJ2mVdYv1WutNiugbRY0f+Qsk1xnpbnnUunWKUaECq/PamXgk3bSv2SDVvvzAlPx
	 YPXTjlK61yK30+XVD0ItCX63Xmy8ixM62SC4EbY9Smf6oZttSbMy0L3dm//CfRu+W7
	 EpWKhYM8A0QPME2Hkcp/LyFyLRMs4OIv5eBilMyE/YGsfSlFdrRs66BD6FrwoyzWEs
	 olaP3ZBnLQfig==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 2032648452; Mon, 12 Oct 2026 16:13:57 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791821636;
	bh=ZchrZpqtkvDWRfz8meSczFuSA2w/MUsx6xnD2KxnOTM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qJylqf3cE2g56hAKdEK09Z5qLT8oxkEQNhyUblWVJmtDPpwCW4cKAUhgI1DkGW0/0
	 whoHw78rnwKC6mTWvdLb+8VQzIqZyqyb+SzwGFi6I/juZ0vR4sIvEdAf31b1ApmtFf
	 6C+2VzuxuGJQ+hUMKn2QbFmGc+Zo8mZZtwQMUwTzmHFWZvfwbQLwe6JaO4yj0Jm+Ii
	 i94bEJOZNELin7EflQmO7kXGH9JTtjzJhq06nSTaTAlFJYHuy9imgA9JdzRT5rRCIU
	 Vg1KmHb/mQXOs21w4ZlrJEWCLBwjkWanhhQs5WVkARVkILm/nD0XPjwEfApMRRnWRU
	 o8IjeBITOw4Vg==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id E92354825F;
	Mon, 12 Oct 2026 16:13:55 +0000 (UTC)
Message-ID: <6030ce9b-1e93-4d11-b9f3-6101fec2229e@birger-koblitz.de>
Date: Mon, 12 Oct 2026 18:13:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] r8152: Use BMSR to detect the link state
To: Linmao Li <lilinmao@kylinos.cn>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Chih Kai Hsu <hsu.chih.kai@realtek.com>, nic_swsd@realtek.com,
 Xiangqian Zhang <zhangxiangqian@kylinos.cn>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261005105249.1281648-1-lilinmao@kylinos.cn>
 <ee122a12-eae8-40a6-bad9-086228ae76f2@birger-koblitz.de>
 <b56624e0-d1e4-4b52-9d3d-de923c471a58@kylinos.cn>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <b56624e0-d1e4-4b52-9d3d-de923c471a58@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linmao,

On 09/10/2026 9:18 am, Linmao Li wrote:

> Hi Birger,
> 
> Thanks for testing. Only the first BMSR read after link up returns the
> latched value, so ethtool shows the problem only if nothing else reads
> the PHY first. On my systems NetworkManager reads it right after
> carrier up, so a later ethtool reports 1000Mb/s while NetworkManager
> keeps the unknown speed it read.
> 
> With an RTL8153B on v7.3-rc6, stopping NetworkManager was enough for
> ethtool alone to show it after 3 of 3 USB rebinds:
> 
>    # systemctl stop NetworkManager
>    # (rebind the device, bring the interface up, wait for carrier)
>    # ethtool <iface> | grep Speed
>            Speed: Unknown!
>    # ethtool <iface> | grep Speed
>            Speed: 1000Mb/s
> 
> I got the same result with cable replugs on a 6.6-based kernel. The
> latch does not time out: the first ethtool still reported Unknown 3 s
> after carrier up. On the 6.6-based system, the network service of a
> Chromium-based browser also read the PHY first, so other tools may
> need to be stopped too. I have not checked your setup and have not
> tested an RTL8153A.

Thanks for the explanation. I re-did the test and confirm that the fix 
works. I tested on:

RTL8157 (5GBit device, 2.5GBit link)
driver: r8152
version: 7.1.8+deb13-amd64
firmware-version: rtl8157-1 v1 2026/01/01

RTL8153A (1GBit device, 1GBit link)
driver: r8152
version: 7.1.8+deb13-amd64
firmware-version: rtl8153a-4 v2 02/07/20

both worked flawlessly. I tested
- plug/unplug during normal operation
- link-changes by peer in normal operation
- plug or unplug during suspend, then resume

Tested-by: Birger Koblitz <mail@birger-koblitz.de>

Birger
