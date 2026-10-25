Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792929153;
	b=04tH+KlZpKJI8vzCBmEvl0ShUjQlhu8incnuSj7vGaKDp7abqC+4+JHxWnDubxlLeg0b
	 TqjMLnzwJVtxGoo5LduN1ctbCiBCe/t1bTwMEZrIacU75oTfwLI2JojFQFQozyYBZE2XA
	 8Ugwm1OSQcAk96CIrkK1M6uQB/OMjmVd12OOrWHhT6QSkZ6WOsmrRMP/H39ZUJlI0iwiy
	 rHY6NsQBBg4UxPuKId12WkmkmDClkbQVIXcNiNTFE4zclGzq8aB8xv66nIdC8IWAyWh1f
	 ohuC6A3xHV10QTHouD3keECe+5FplCGvdTXKK9EL7FIXaPLWcwe5y/oiJfCslFZItEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792929153;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=9CEWfORfntv8VkhsX5SGmYSPLl0+f9APEy3k75g3Ges=;
	b=PTLlWtamVb7vaYK90q/zDJPVyvC06kOEH8VkM82zXekNnp+NrxElQbE5gEu27jNL71UV
	 iZqSIpuS5oDXK08DmX2U6x9UI321KnragK0f7Ky5nG9R6g+f+u9XQrWo+BOVtzHw8SmJQ
	 krE53fpo+aj0wUPiw5Soo3dgskwaqUpZmIWzmtKnXvya8T7+zP8UOOyF9FM9YRBNVN0FK
	 84SqWDyqCpmv1RRCQOZsv0Jf/PfPODkyovN81kpw3bvncMs0HOqKUVjQoOPS1NGlB6J4s
	 85zMN5bT+9g6+jh9rcg/BIIr3medXUMW85hx3ML3cIjuYQq2R69IP46cTdusLxxP5gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXvSlVnD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81698606A31A;
	Sun, 25 Oct 2026 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXvSlVnD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D311F01825;
	Sun, 25 Oct 2026 11:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792929153;
	bh=9CEWfORfntv8VkhsX5SGmYSPLl0+f9APEy3k75g3Ges=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kXvSlVnDH15cWbO+1dz7W4fA+T+ypLAoZ5VIau7XmbxS6feD3VAzBV1LffLw5p6nH
	 NQGjuMGAlXxYHVEuvpQ0vcRtODFwdjaIc0xgimwJ4L/8XTFRcIN9lwnrg0BoCXQTqk
	 386sgwGM/6HyI+6Tuz5K8dPrXes8XavbQRl9tpJKTcviHkxSJb1Knt8DPmVJw+J9zN
	 poVRvHhxtbzIXdvplQThOA+xbji8a5V3vMiF9TSUAjcLn8ogW4RhCHq9dwQuEuLFJE
	 oThSBPZwm4yzahMxKEfSeVBAu7ay/18ITsC084l18AwdnVqAfO7yH3ERFL3W36MsR7
	 HQiXEUK1N8C8g==
Message-ID: <78127b64-d4ba-4e72-87fd-28e26f989de9@kernel.org>
Date: Sun, 25 Oct 2026 11:56:58 +0100
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
Subject: Re: [PATCH] fs/proc/task_mmu: return -ENOTTY for unknown pagemap
 ioctls
To: Hengyu Liang <hengyul@cs.unc.edu>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, jannh@google.com,
 pfalcato@suse.de, usama.anjum@arm.com, avagin@gmail.com,
 mirq-linux@rere.qmqm.pl, arnd@arndb.de, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261023181300.3366487-1-hengyul@cs.unc.edu>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261023181300.3366487-1-hengyul@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/26 20:13, Hengyu Liang wrote:
> Commit 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and
> optionally clear info about PTEs") made do_pagemap_cmd() the ioctl
> handler of /proc/<pid>/pagemap.
> 
> However, do_pagemap_cmd() returns -EINVAL for every command other than
> PAGEMAP_SCAN. Before that commit, pagemap had no ioctl handler, and
> the VFS returned -ENOTTY for these commands. As of now, they fail with
> EINVAL, so tcgetattr() and isatty() on pagemap report EINVAL instead
> of ENOTTY.
> 
> The issue can be reproduced with a simple C program:
> 
>     #include <fcntl.h>
>     #include <stdio.h>
>     #include <termios.h>
> 
>     int main(void)
>     {
>             struct termios t;
>             int fd = open("/proc/self/pagemap", O_RDONLY);
> 
>             if (tcgetattr(fd, &t) < 0)
>                     perror("tcgetattr");
>             return 0;
>     }
> 
> Before that commit, the result is:
> 
>     tcgetattr: Inappropriate ioctl for device
> 
> After that commit, the result is:
> 
>     tcgetattr: Invalid argument
> 
> This patch will return -ENOIOCTLCMD for unknown commands, as
> procfs_procmap_ioctl() in the same file does, so that the VFS turns it
> into -ENOTTY.
> 
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
