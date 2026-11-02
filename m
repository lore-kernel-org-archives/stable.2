Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793583270;
	b=IN8IrSZ3SepAuUT6zCTez/zd2pUN4o5i867MU/DXaoboNtmnCIf92fizW/93uviqMnoz
	 n9PN3f1jL9iUkxXQzAhQrOZlvQ9dWhfXz2bHvEXzLmR1sBlG3p1y9vPhWEuKF+UP+3UKb
	 T5sQKWLPIBwIzQUbTM1KOnk1C/XTcc5vDDpHuUG53G0n7ggAXZnF7CqbO/JzUbEney65g
	 uL+v00T+bk9GlrLE8MiqDDTnNute4IjXEvIvCPjacGkS0aahwBauv0dQCSyZcZGPvgalW
	 ZW4lgoVzjgaOojtzjmdxTqqRl5tn5ZCPMuobF0CTedeXLsNkWH1isVw0SeMCfJjEiTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793583270;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=DMbdpKsPHWH/BwqYOKc1EJMdIZ5fFnDiu2ukpAHKdUs=;
	b=kopuiv39CmYwDGS3S3A3RDK4onvp+yv/Zg2OdsOk7YG5TNIpnygdSMeBUYu3prT5oG8j
	 9WZ17jkr76v97uE7m9WCxdRfwseITvc5gsZc3vl3+7ZTUlVJt/ZbTb/wx8Wj28WDMPpPI
	 63hgGwjLbRE2Xo31jnlztFnuMjRqqBBxrse3RwSDD4ptrmFQSZQMGnZ6QA/J5C5vGpEnA
	 XzdoPN6YhxNpQAzNjq8FEeSZ/2ENPAt8VGZPeXuAw+aCcl91MZDL7uxUuEg0MrojyBH9S
	 uRuS+Amk6Jm6+5AMFpSvOUjIJVD/gEWcfFD0LJuDTzQ6UA1bKXeZQdhAhkZzlRiIG4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="he/ubJEF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290F7606A324;
	Mon,  2 Nov 2026 01:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=he/ubJEF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819141F000C1;
	Mon,  2 Nov 2026 01:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793583269;
	bh=DMbdpKsPHWH/BwqYOKc1EJMdIZ5fFnDiu2ukpAHKdUs=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=he/ubJEFkpHMEvld/1emBTae55d++wHB68zn3kFvlZ4A/xoTpXDXcIk8shOjkb9LN
	 vAChI33IgvBoJHP3iJf6Zw4tlumzCLR1/E7MAMrQ2WrMRyAiv8x3EpyA3W8J843yqu
	 fzQZDEWkWZNFexPvS3LwJdyBwaquVwniIlq84qgA125woGwUM10nUbXEjUkScbfa3R
	 vpPqU2CRdfTK0SJUUctrDNSiAzMf5WU8AVm3CqfrS4PvAyulN8CfMpLkjk/ze6lxMn
	 6Yxhjljabyo1P+K4toOm6/TWC6db/U69dOdru5U5iVuMTLRO1r5cbFfoLOGyJJGyVi
	 J2F2ZfbtK5YcQ==
Message-ID: <513d4f4f-dd02-46b3-87c5-f95e9ff47a41@kernel.org>
Date: Mon, 2 Nov 2026 09:34:25 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, lihongbo22@huawei.com, sandeen@redhat.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 zhanxusheng@xiaomi.com,
 syzbot+e818dd42ada3b583bed1@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] f2fs: fix use-after-free of quota file names on
 failed remount
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, jaegeuk@kernel.org
References: <20261030072423.197883-1-zhanxusheng1024@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20261030072423.197883-1-zhanxusheng1024@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 15:24, Zhan Xusheng wrote:
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> f2fs_show_options() prints the journalled quota file names without any
> lock that excludes remount, and a failed remount frees the current names
> before restoring the old ones.  Reading /proc/mounts at that moment is a
> use-after-free.
> 
> Read the names under rcu_read_lock() and free them only after a grace
> period.
> 
> Fixes: 4b2414d04e99 ("f2fs: support journalled quota")
> Reported-by: syzbot+e818dd42ada3b583bed1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e818dd42ada3b583bed1
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
