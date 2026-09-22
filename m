Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6317B2D949C
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 03:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790048192; cv=none; b=bC1eSyDQL82ZjKEDws9nbBlrgSVnYI2LMg7snwrFFCpfgqFIZ/KdMrNQcstN/3JzqScUcZPCjdnPTfWsB0PI1fLRuAPC1sNkqJHXD7+3IoSs3zg5N2RhEKwv70kyJ6/9ehUB0zpsA09x+4DfRECDahB2A1SlpwK/pr7YZIxPidk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790048192; c=relaxed/simple;
	bh=RzFOag5CHicLMswhXD5eT0XX0xDFqASebsK3QgKd6QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L94a2cy6WrQGvV1KmP26fVKFJaPzj1kuCnoajhungDX3Ol+A9I+voAnLJG22dY9oFJkSDRw7UvngBVdd0QM49PPEjbdSpAHqBx61oXGaxc6K3JtNDbgECIAwI5m9uNIcyMk2dlS6LMn9yU49izvj/aLx6QVh+hWk7nXWRo0IhMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpR0kmd6; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpR0kmd6"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc147d86bebso546208a12.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 20:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790048191; x=1790652991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RzFOag5CHicLMswhXD5eT0XX0xDFqASebsK3QgKd6QM=;
        b=jpR0kmd6hBsXzt5kU2cIRrMTCQ0mf1ox/8z8ElW0OttJvGEoTd7mvYKGsLCKg81/pV
         JgtxOtrS9/ZmfhE12DjVfiJxbI13Ezzv+AqqrOaYdq1rh2sESudCuY5bQzDczlcnj16R
         kjPNxWNAixPgrsXKsbWUFr33xYZf2S7/2KFMQxlkZ/+jQAKRaLexsB+4Palc/4ghI6aV
         1Sjl+vKmuIeIuWCukbnhfiFzV9US0pKdNv9edWIQRkL53smo+yJhaIKqtIau55tFzbuS
         v4MaVY2IINus4RO9I7CePirdZy55vCJHujX5D4E4FZi8o/j5h27EGB7af/Gd24qzpcil
         AH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790048191; x=1790652991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RzFOag5CHicLMswhXD5eT0XX0xDFqASebsK3QgKd6QM=;
        b=yOMXUjZ70a6d4dk2fIkv+PeWo3r8i6Pf8lpHGpWa2uNYHh7d1U/Z5xT2umzf091QfQ
         h5kxbdOXjii9OYpTBGcltsMujI+OTsH8cpLxvtvVWrbdgY1NyXIQqJmkl4zYd8bmvMDO
         YRCrqfjz/+RJvRSvpdBChPobPhmRYb0YFhabLkfdXQv5SpzeAtbVhvijiGQaNPMc9uS5
         mq4IoLdGw3cMofDhGX8YHxMBhk+6AiAv19KIwppz7LzpjWsH5h67VpJAVBCFuda1wAQM
         gtY4kSIEDbThcX/KPQuNYB/djb87CbwdPkoN0v9PMGtUur6Ei7j1vZikvZ6dQGnl9WLN
         midA==
X-Forwarded-Encrypted: i=1; AKwUvBzQNR6bpEdTZzlCFlOb4JM9D0B4os75QOmCsfm8qhqwgM30vjOhtSdP8BOFlHvT0Nvj81yiIPI=@vger.kernel.org
X-Gm-Message-State: AFuF++k9zGuUY/sHJ9pq7F6u373ke9j5BVBjYlUge/BwFGfH+its87ZK
	bwBT5rbxL2+ZfAE2mjGyWspu/TtY7IRZ1aaDWOynPNV7TZF8WM0r0VnJLj32jAtx6bvzpw==
X-Gm-Gg: AYBFou0cSb22FBxjPpbbgIe+A13yqZcM9SIUnyaLauNrEwR6XUY4I63p3i+V7+H/ylh
	qtYf6MNaMmaFEK+ueqDEuOSTDF/ohI9XX3nmRWvEVC0FtYndVqiZen7ybVJaYQlBv1i6pwadu/1
	Q2w+70GCqRhRLzIJiFh5FvUC7vsAOECbdgByx2OcehGnw+xtLb58ZhQ3Wy8hK4MjQMubPIfdgcJ
	RE9vlrVS8IVwYrqYat4HVdf7TD0mC5q7QlawE9WA7aX8dNhbcEDdIiQDPjK1ESnjCpHzYYPjEHe
	1TyQGiroJ4bzxUFTmpSTw+6iJAd1FVMKVLhmngVBklEFvREX5h+/YWvpZ2E4oWVBGyIFaW1zMz4
	XflJ5Y/l24rjf0sQ7q1Bfrq8tYFh07F/UnWzED3d/9ud41S0w/xTkYkmIOzdPgVo/HFlpk7jqjm
	QK+vu3sfGvyKyJQJhLH2HUukf6G1JcTQLuER4q+e5m9mAbc9GsmTGLqboP3/rb5HCXCKMP
X-Received: by 2002:a05:6a20:72a9:b0:3db:752:f89f with SMTP id adf61e73a8af0-3dde0111e01mr1467764637.2.1790048190604;
        Mon, 21 Sep 2026 20:36:30 -0700 (PDT)
Received: from localhost ([180.184.77.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc756b48cfbsm150925a12.24.2026.09.21.20.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 20:36:30 -0700 (PDT)
From: Dairui Zhang <zhangdairui@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	stable@vger.kernel.org,
	Dairui Zhang <zhangdairui@gmail.com>
Subject: Re: [PATCH net] af_packet: fix integer overflow in prb_calc_retire_blk_tmo()
Date: Tue, 22 Sep 2026 11:36:27 +0800
Message-ID: <20260922033627.1443968-1-zhangdairui@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <willemdebruijn.kernel.1b65de0a75434@gmail.com>
References: <willemdebruijn.kernel.1b65de0a75434@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Willem de Bruijn wrote:
> Code Looks good to me. Thanks.
>
> As Fixes tag do prefer original commit f6fb8f100b80 ("af-packet:
> TPACKET_V3 flexible buffer implementation.")

Thanks for the quick review, and for the history correction - the
unsigned short truncation detail is exactly the kind of thing I
couldn't have known without your pointer. I'll respin as v2 with
Fixes: pointing at f6fb8f100b80 and the pre-hrtimer effect
described as you outlined, after the 24h wait.

Thanks,
Dairui Zhang
