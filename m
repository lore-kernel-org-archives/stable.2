Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795049061;
	b=atGya07BUzeSLK6ZtN5BYKu/d1hxnl4OtOTTBg1fJrV/gcg+Bi3jrENqdrz4X7RqbeZw
	 vgYaczh5AAAQyYnlnPUMQb1p9L+eLcZDOQfnp+1WC2Utzekc6J+3Y8Uw6otNEeB1G7R+E
	 Re4Ufy04cUGdyXl/YCfH/moYWhvt6oqKfftnzyvaCRgfrKW2pCSyIDM8bka7s7iK7pbgA
	 iKDyLYM2FbBDE3JHgbRSI9/YpjUnHNINkjiq/xdqciYyn5/4cDsl4OvZEZ3UFjCOVZUDc
	 GpY9RTyP5UEEoacjhvQ5AqI57MVw8Bzeha8D5TAgyfKqNU82/c8B8lzlIMUOCVyVa1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795049061;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=C3oqoGKdCfAOmvs0lJZNpvn/LX63ooMrBqEZhNAURoQ=;
	b=2WHQCNEl5UEkG37bBfHfYSliVLa4pUm55AjoOJm0Mo5SOnab13xjFJqoZBQKGfMSN3ZW
	 KmKzF9xDwoaY/Xks+MpsR6fbjOcSMd5fHo9Ls+J30H2ou7QD9rOnOdaC2Vqf4JrEgAB0E
	 T1fJo66yF0qQ8YpxzL+NGkfIzHfO4c//zbaquYDVu5Cml7VmlIFKhEmV/l+R1ITNSB7u6
	 LMHOgZCWAOvpCurHjmVwwCIBpjCpdvwMnnkpBi9EKj0k1K8A92ItBUDApGwk2KekIBlO+
	 GgPEDnbLCRHh2/ydYxRlk/qe/xcMugyCK9r2tXBKWNJBQdoPShyyc65eT9agIuN2HKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fd8ZlyaR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48445606A325;
	Thu, 19 Nov 2026 00:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fd8ZlyaR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995651F000C5;
	Thu, 19 Nov 2026 00:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795049060;
	bh=C3oqoGKdCfAOmvs0lJZNpvn/LX63ooMrBqEZhNAURoQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fd8ZlyaR8+7VKkyn9agtYfcIQ7kyb4uKP2MBSv4tp8VpP3wc4I7kPnNQnsCYyjT53
	 Fa85k+ZWKPYQK3atw3lgWCKQz/JFbnCAI9uqlcD9G2cPcCSTGmcehgh01aJuxuU7TC
	 druMTJOkUp91pOa/4JedUmfx1zhIRZPkFXk4vs1AlJ1h9DNTo8fXDf12B3lfeJKfBa
	 8JA0JUrBNmVC+vcx2b4wjsmGlUXlxMvCecCPLf4dV2Bko5Xql/D1c7HQibCXfFTfna
	 AIxZ5DZyNoa0Du/lIzrPIjnMohFUvr9XEsz73rFPJW3ZfNsYgTb+9A3gmENOdj120W
	 OYRhwp6Sj85sQ==
Message-ID: <88ec005a-db15-4710-a527-0a270b138aa6@kernel.org>
Date: Wed, 18 Nov 2026 16:44:19 -0800
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
Subject: Re: [PATCH 2/2] zonefs: ignore RLIMIT_FSIZE above LLONG_MAX in
 zonefs_write_check_limits()
To: Ding Feng <dingf3ng@gmail.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, naohiro.aota@wdc.com, jth@kernel.org,
 stable@vger.kernel.org
References: <20261117173129.61028-1-dingf3ng@gmail.com>
 <20261117173129.61028-3-dingf3ng@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261117173129.61028-3-dingf3ng@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/11/17 9:31, Ding Feng wrote:
> zonefs_write_check_limits() follows generic_write_check_limits() and
> has the same problem: it stores rlimit(RLIMIT_FSIZE), an unsigned long,
> in a loff_t, so a soft limit between 2^63 and RLIM_INFINITY is negative
> and every write fails with -EFBIG and raises SIGXFSZ.
> 
> Keep the limit unsigned and apply it only when it is at most LLONG_MAX,
> as the generic helper now does.
> 
> Fixes: ebfd68cd0c1e ("zonefs: Fix O_APPEND async write handling")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5 Frama-C
> Signed-off-by: Ding Feng <dingf3ng@gmail.com>
> ---
>  fs/zonefs/file.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
> index 319d950..ea9582e 100644
> --- a/fs/zonefs/file.c
> +++ b/fs/zonefs/file.c
> @@ -399,15 +399,16 @@ static loff_t zonefs_write_check_limits(struct file *file, loff_t pos,
>  {
>  	struct inode *inode = file_inode(file);
>  	struct zonefs_zone *z = zonefs_inode_zone(inode);
> -	loff_t limit = rlimit(RLIMIT_FSIZE);
> +	unsigned long limit = rlimit(RLIMIT_FSIZE);
>  	loff_t max_size = z->z_capacity;
>  
> -	if (limit != RLIM_INFINITY) {
> -		if (pos >= limit) {
> +	/* No file position reaches a limit above LLONG_MAX. */
> +	if (limit != RLIM_INFINITY && limit <= LLONG_MAX) {

As the kernel test robot pointed out, limit <= LLONG_MAX is always true on
32-bits arch because limit is an unsigned long. So we need limit to be an
unsigned long long I think. Same thing on patch 1.

I am pulling this patch until this is fixed.

> +		if (pos >= (loff_t)limit) {
>  			send_sig(SIGXFSZ, current, 0);
>  			return -EFBIG;
>  		}
> -		count = min(count, limit - pos);
> +		count = min(count, (loff_t)limit - pos);
>  	}
>  
>  	if (!(file->f_flags & O_LARGEFILE))


-- 
Damien Le Moal
Western Digital Research
