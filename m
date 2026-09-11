Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862615A5132
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161358; cv=none; b=QOMi+8vnEAangWEPQBrs3OpzZIW+0I8DvJoJpNvmV/apV0m12sqe6cBBeHcIkXEzbubgAPoTzYre5TeGAqnpY1nnjYdS/nSYItuQDgxPk4YInpWoyknB6Mb1VF+xz+Mrb3aWs4OzZbY72nQoxCbmYvYlA5hUeIDrg5uD7zovsFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161358; c=relaxed/simple;
	bh=4+gZNPWyIJ3mCtYhhOmkl1E9lPQeG02urbagnaEJsd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDBb8V2hKer4cRd27EiNa3TJJFeIbLlIElMoOL+AxH+8rrKRjpQQL04aL4+rxUU8uOjnGybtVIQjxCgSnLrymGWd7ouKfbBpX/Zk3KY1qYPUv68ZuqEJDjwfjxlpYw840X8jYivYQBSDbLr74yuNM0oqUrrTkqY4201klHTEPTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca94bso151905e9.3
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789161354; x=1789766154;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4+gZNPWyIJ3mCtYhhOmkl1E9lPQeG02urbagnaEJsd4=;
        b=l08PpsyfFF91MYzLXn8ySsFP9K0SJRS16/xGO8p9ZwllYoYJvYel7HNHSLHROBg3hE
         tJgAcm/Sf3lkwE6OuPb24CbBG9wCcYs/C0wcrB4/SZ2dh9YQvjHmUuJFeH0yiawdg04Y
         WINK907TlhsarEkGItxJGKgsohOG/8srCQBn7lz/qqad8kBb/3qDY3AjtgyPRDZD+huZ
         UVENcYgRLp7jvOcTjLS6frwXHqIu0qtOYOyMSZKSX6xwcEuTJ0CtgnN5PALvl+1uArs2
         MxR8+GNr9uwSjLxSNPimDc4indrApuudFutmHpgdBKR71xnL2/RrIIzmL3ShSI8hZ7TY
         A3vg==
X-Forwarded-Encrypted: i=1; AKwUvBxkEw+Hfj4d/zFViNOME9ly7lGgu/nGL90fo4ElEKvHjZOzqWrtp6iofrxDtxW5hDPDQ2O3ve4=@vger.kernel.org
X-Gm-Message-State: AFuF++lCb7w9EU4pFbI7gV2JiJvbfAbV61KBw9CI2uYj20PdtwU1Dc8b
	U18QCyzOC/1H8JXwbAtALWMXkwO+TwzhYpdlfjUBK4/Z/V4gkVx/0YtD
X-Gm-Gg: AYBFou2YZtfncsgmdEJHe6go4syI09SZHfFlDfy5RhKR3tYIEam28zO/6w8jMjYRG0T
	RC/rU2VC0dGW4dW5JbjBUnagNPyMT2Ba7tfGgvT7fMYDro9wRYsCLpGRFAM/AhgPvAZKgvEgBKj
	EkLGBdaNuGURiQBYlJgKp+Bav6KEwPd9rlgNb/xHFOvyy+sjMpT9tcQ19L1phbLP4kFuFTzIupR
	uIOIoujipY8iHs9iGNP6gYcjFQ+x47ClEVQflmZ71CPrD9rqUdwQ5LBTYEeBfWtqSFEbcSzcsJs
	X/jLDYvH7jclKAV1lZrdMOPGsw6C5fyffWj4WAWUNd/wgKeEYeddNjBDT4SCqCig0hhLrJYChqv
	ZtBdug9QKvKyFzJxYhOlqQApyICPuM5q9QwOft8VKUVWoSj33qOqVg5br6R01K8o3TDrwTFp7FS
	ZvAfIQz68IpGONEpD+SRpeyigkrqWuwVEyg27xXsBka3YCJQILIXcjlKtJt6h93O4fe/obh+mDm
	1KMdjXUlmdCqIPaL2ImJ1njd8QwzcE2
X-Received: by 2002:a05:6000:491e:b0:482:9dc6:16c4 with SMTP id ffacd0b85a97d-486f6bd8b93mr285658f8f.1.1789161354138;
        Fri, 11 Sep 2026 14:15:54 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ebe4sm7149818f8f.14.2026.09.11.14.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 14:15:53 -0700 (PDT)
Message-ID: <d040bea9-711d-4638-9d64-50516709b41b@grimberg.me>
Date: Sat, 12 Sep 2026 00:15:51 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: fix a hang on queue teardown with data digest
To: Shivam Kumar <kumar.shivam43666@gmail.com>, linux-nvme@lists.infradead.org
Cc: Greg KH <greg@kroah.com>, security@kernel.org,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, stable@vger.kernel.org
References: <20260901014718.2835558-1-kumar.shivam43666@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260901014718.2835558-1-kumar.shivam43666@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 01/09/2026 4:47, Shivam Kumar wrote:
> With data digest on, a command that has received all its data waits for
> the digest in NVMET_TCP_RECV_DDGST. has_data_in() is already false there,
> so need_data_in() is too, and nvmet_tcp_uninit_data_in_cmds() skips it on
> teardown even though it still holds the nvmet_req_init() reference.

So nvmet_tcp_uninit_data_in_cmds  is where this should be addressed.
