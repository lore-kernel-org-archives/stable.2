Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793228879;
	b=YsdrV8TxMsAj9orPPUSn1z/xpu67sbsvpvv0vHEXtUGOGwXxuufmKrVHrZvHAimkBUYV
	 cmpa3aL5gZyDHR5b2Q4b7bPMGtqLLIUhKLbPv6ItTcBLuD5+er5SPm9L1YSVKOXCpMCsS
	 4bcKOVBFWkBA7kHUkopd1/iI2CKTVLmU1fLaJJFTx75LEJ2D8QB0gluabVMFaefwbITpD
	 nqiGchuLEmGAOtt/RckuDDisRkOJUcwTRlcjVpK5Z1ZqyHpxBr70WRjjY93ToQH6ZNMPn
	 lSv7pmUBQxH6zHMv8zt0jh9NEOsOTSTRPQ34b6ddOxSOL23d7/Iw6yyVw0YWLmleMWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793228879;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1yPRzjaxwAbdXrP6KueZlpcv3HyJ0rJfktwvgjDHlp0=;
	b=q9YHmTdX374C57ky9dQg2LN645zs3ZsV/KVEg1mSHubrVIVZ7awUxYG14xo1rIToelyj
	 G9jGpFKOqv3FyvRoVTx7k6mliF9aKl0Eu2iUhbuyfOB7NcNUtxrTyadoc5isS6uhds0ay
	 X1y/td0GybpStnsYvihiX/goMtWJlE5Rn3Z22O0dsIne/CerO9GydgyqtNpNJbsHfUuKc
	 Y3WV4GmMCRhhR7BUvhZ6Te8tLtv+AbivKTfYT52W48Bj4DYjzB1mXd0xm1fv/gRV5/oLl
	 mJgcYH9SRSQYXbNgoY2FqWXQ/UNXLuE/CXNduYRzD4SKlJquu/4/XYnZEpWb1Y18USA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OunRAseH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F818606A31A;
	Wed, 28 Oct 2026 23:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OunRAseH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE51F1F01825;
	Wed, 28 Oct 2026 23:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793228878;
	bh=1yPRzjaxwAbdXrP6KueZlpcv3HyJ0rJfktwvgjDHlp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OunRAseH8A/nYOGi6fAES1iTRjW/jWJHaN7aZklbbr+1XX8+afO+r75A6+z4YEo45
	 p6SRpDGXlpho/SyhaP9mQIG/qLAPjRhZT95JKvwO6JuVxbb28XAr8zixAVJbnpgQ9P
	 /hU0LX150h+D1Wez70uR1XqjohWfESWosz/YK/sL1D3tat4kauivySlYi3gw6K8X9r
	 3Gy+26G/Ph/jw2rBKsjOR6ozj1Bcjr1qfim6YVSx2AaH2z7tLmz7NySA9qdHEAlXIo
	 E6+FZvX5eS08venim34c07ahmHUrjkjMNva+Eb1QemIVzr7po7P5EdOLbXlFjt5ivF
	 DhjDgPwNPSKIg==
Date: Wed, 28 Oct 2026 16:07:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, Joel Granados
 <joel.granados@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, David
 Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Thomas
 Gleixner <tglx@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, Fernando Fernandez Mancera
 <fmancera@suse.de>, Willem de Bruijn <willemb@google.com>, Maoyi Xie
 <maoyi.xie@ntu.edu.sg>, Gerd Rausch <gerd.rausch@oracle.com>, Zhan Xusheng
 <zhanxusheng1024@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Chia-Yu Chang
 <chia-yu.chang@nokia-bell-labs.com>, Yung Chih Su <yuuchihsu@gmail.com>,
 Wyatt Feng <bronzed_45_vested@icloud.com>, Hannes Frederic Sowa
 <hannes@stressinduktion.org>, Flavio Leitner <fbl@redhat.com>, Petr Mladek
 <pmladek@suse.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 5/5] net: restrict message_cost and message_burst
 to non-negative values
Message-ID: <20261028160757.210f99bf@kernel.org>
In-Reply-To: <20261027104701.296240-6-jiayuan.chen@linux.dev>
References: <20261027104701.296240-1-jiayuan.chen@linux.dev>
	<20261027104701.296240-6-jiayuan.chen@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Oct 2026 18:45:33 +0800 Jiayuan Chen wrote:
> + * Returns 0 on success.

kdoc format needs an explicit : after "Return"
-- 
pw-bot: cr
