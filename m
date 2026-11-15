Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794708467;
	b=0N3nrbtRaeIcILvEwu17VHHH2/qwxik3MFJa3iBAVNHqu/Zi6ze6DaGg1c8nWsmKjqN3
	 JgLBcM1r99tgiRycx/eN4MCOeqN/sjhQGeD6RH66kQufWRofXxZ5mFUr+EhLdpkdf9J0s
	 Rq+GsDrcqLVuPpBeCGNjuZXD/UnNzNTwHpObesdsRCBcz4kRbht07rBAbjAtyGBuMKXvH
	 kMWoEiHbDo1qxK3saoM/QpnCWDRlAsOsF3hlCIBWZixM1eFD7rh154P6hNqX0kDGzHhoC
	 hrahT5UIpXyRbUbNb5hRxfBoZwF5au5c24tGKcSaxB6+3/fR9WursbeGtQ3K/R4Yn3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794708467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rnqu5ao9YJwk94NMnB9wLTZ5Ww11Mzaq96WX6a9SCys=;
	b=1FRyluu5zOYGBgSwWAekNzcuLk9/LUpjlgz1NIONN0/r+ehqDXdwp0089mlNxYjMA6Xj
	 JfaNz0K5Rg1V5j6gZ1Gejq7eEYSu2EJaQ7iPxKJD7+vk0/GJBJvnoCQJ0MsvZKi1YiMTe
	 jlXt0+42Z0rhuCbK52eUvdfm9OFUA8KS8/NGsw+gg3wFFGQwlj9V6IpjeeekaXgsQIf6c
	 Gd9bsPXYIqMZJHKl/+HosVrBpGkQGvBAO2Oas8H6ucyYjsRUls4uMXRpW+6CMs4Y6/dTM
	 88SjrlR90BqvWTrir8GN8WucKqPIo85S1x25xmFMFdRICuayFGAyzNj69/lZI2Wvu5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hLnlNQK8;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C84606A32D
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 02:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0C84606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hLnlNQK8
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-862b76e3c8cso71125a34.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 18:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794708465; x=1795313265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rnqu5ao9YJwk94NMnB9wLTZ5Ww11Mzaq96WX6a9SCys=;
        b=hLnlNQK8veP334z+eVkUDAES3G1yQmoS+IwKg8o4QOrZ6P44r8AkjMZlynKd27RZbc
         p+nb1wVMj174+IPPxl8ZBp7Mmc5FGxR09y5xaFBVcsIF2IQaee1ma6hxIbz88svT+mr5
         SyMgE+EeIY8vD06U/mS1vcAuJz4LjrTAHL6vptfjVDeAtuat+fAIJPECALmQi7y9O38M
         BhwxmXVSzb7x5q4nPK3ol/34LXAE4t3yqVJf97ZATIecE+cbI1sOQjsLhYaURc6YgJuI
         vV/WeenOkKeTh4I3Vqb081WEucdnNXZ3sgcwyW30M3qGGscFejT1hmq2KswuO8nwqZgf
         2y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794708465; x=1795313265;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rnqu5ao9YJwk94NMnB9wLTZ5Ww11Mzaq96WX6a9SCys=;
        b=JEAdFPMNKFERPeusxGAPuh5JG63RJ0LAOeuE3gvMuai/yQ/y8zEPxNZeBGpf/df/tf
         a6YdDs8btKjirolM04S6gmrTBiA5KaybG0ucD9BRtMqiWDjnNz00DW2d/ez9jlS+Xq7n
         x7w5Z1GPZT1xH8Xc797rEfczzhJqD+anDassbVvMqoN0k1oIYw1v+fpNyTCiNLYLsxgC
         TKVLe+HuVc5vzV4p87zrLHqHIulv0AnYjRSJqVJ+od6CYxYR0QXJaqLXAGN8mAOSWHbx
         siAVsMT4Hswfwah6WJTk00+QbXAsDEKDwawUwFVjTchzkccB35aI0kufTcDIlANy+OVb
         K7DQ==
X-Forwarded-Encrypted: i=1; AL+hErGj0cOQZet5S0h3qkiU72avGph2/WoDsV6jCMeUNmKXPA6P09uigO9miO0r4S0vL8D28wxN9AE=@vger.kernel.org
X-Gm-Message-State: APuU4Z81J9iHoAVGYKkDwvZ3O/XZvZL6e0ly++AM//mm8Yxtka0H0hG7
	tt1Zh/rKzpJ/0s/yA6vSWr1bhdQa3QR5RyZxhLqrJ4S9VJi8VxVpBCtE
X-Gm-Gg: AYBFou03icmpH+jVZUgf65y4ioZVOiiGyTXs9BfRTKDCw+EXthpmUnVwexKa56NFADx
	z227jWQ1hmmg1xwbprOLmYknS/rM5fGtrxj1rEsNNa7Q11dBJojtKYhiaVfwc6dixFHG6HWlIMj
	FbF0ym0OcsVbnQ1zxCWxwRpFDpRX/1rvpjkqVf9s5LMHQHGeOW3RMl+ZtBPzuDAWZ53jfhbG9N9
	6JUCJLTHG+dAoKzI8n/OLJK72763UHgazKqmDRN9//1LZnPn3qvdB6A47aSLCAEFqO8cFJOIIGb
	nLhx7IOlOn5D15n70SBVotqwZG5RRjg0Y5R+Bpvj8+7H7LcnuDAouL7D4/e2hUpo0v8ZZSIpCqR
	8GkYwj19o8YeaNAWRF+sXOOoxvITF4ZXqjFBtThNSjuXUXBFIJdt7AKM6BKxaymjazHA0JoxoWC
	sznLCgLf/mhlA8eIdfpSHGcH+4SvDEN8Hv1wOXOoaiHGvKIS0A8GzNuBm7QnesAs8wNw8v8cAQ7
	FiJ8+2w3XC7SSZ4/sX4w1VyvdR4v6Bv8LKPoprHtBD+H65tC/UXjL62Pr3JLZ5ClY2pql3XeX4c
	d0tPOytAwNCQC1oOpr0C0iXWmB7p2XNxGjZkKAIWnNukPIl8XKjZxu1j3vntfekAdMdlK4vLYuE
	ggqRk1H1AsB2zskR2tdwZSwmQlUU1ninF
X-Received: by 2002:a05:6830:4104:b0:822:527e:f653 with SMTP id 46e09a7af769-862898681aemr7487703a34.13.1794708465542;
        Sat, 14 Nov 2026 18:07:45 -0800 (PST)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862880a5298sm7113595a34.7.2026.11.14.18.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 18:07:44 -0800 (PST)
Date: Sat, 14 Nov 2026 20:07:35 -0600
From: Ming Lei <tom.leiming@gmail.com>
To: shao.mingyin@zte.com.cn
Cc: shuah@kernel.org, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/4] selftests: ublk: propagate stress worker failures
Message-ID: <avkT5yu3hJgi-YWb@fedora-laptop>
References: <202611112257529855AMDZLzg8ZmFDQ3fBstbi@zte.com.cn>
 <20261111225759742pwhACD8p_0GdXSYIk_Ob6@zte.com.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111225759742pwhACD8p_0GdXSYIk_Ob6@zte.com.cn>

On Wed, Nov 11, 2026 at 10:57:59PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> The stress tests update ERR_CODE in background subshells and use a bare
> wait in the parent. A worker can therefore fail while the parent still
> prints PASS and exits successfully. Calling _show_result() from a worker
> also removes backing files shared with other workers.
> 
> Generalize the recovery PID collector and use it to wait for every stress
> worker in the parent. Return errors from the worker helpers, leave result
> reporting and cleanup to the parent, and reset the PID array after each
> batch. Keep failures ahead of skips when collecting worker exit statuses.
> 
> Fixes: bb2cabf23568 ("selftests: ublk: run stress tests in parallel")
> Reported-by: Ming Lei <tom.leiming@gmail.com>
> Link: https://lore.kernel.org/all/avJ0Vn9G7XhZv-XL@fedora-laptop/
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
