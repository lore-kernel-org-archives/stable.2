Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904135;
	b=Iv3OLBP1y1ecZxfDdQLhh/oI5YUtX/6ziOo08QRkHa14b3yYoSvByEBZ92HbrbSOdbG5
	 sHFxmB/FFO1O5YW2Aw8F219PcdGJGMl/X3buiTa4B/v45NZ2HSofHzgms3SMNODRurJgG
	 uzN21bW4peniQ2Xsd6HGyql7kQl/0mHfqGXUGHIeywVKEZeTaI0Xi31/YewxI2xiUqcRV
	 h/ehP7akSSo8sLSASVx6WgfOIWDV7RiO5jb+9AtgyGXnu8DcqZbv4SPR2FlF7tEz1kQlM
	 K6KFgy5kIxF47lxnhQBZj/sCde4AvsXHSG27lYCGeYNWAu3j+3bSJriMwFSnFJQcJMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904135;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=DbVXtjmXEidjKGQfwT1FS56vvbuAVEYXJ6jbibWlecU=;
	b=z5fsvRTO/D3nUjfcCTXrGMKktyu6dNAMD4+0NbxsBB7K/RKi0fSH9+bCCM2PBrjbF3Yi
	 KtCoDkpPhS9nwaf8S8OXkH8UTAOZuHVJze5iREhDki/mSt7Qc4Zj2ZAdrTg3gKVJQA5nK
	 hukGO42Is9vTc7PQI+thhWe5JSM7GXYAtNNaBeDYNbbvUK+ycKagI8KdSJ9HXa/nlWRRV
	 ev377POPawnE8vnSeOely7RjXiOvIIBURYfVG5jAGzPMPpCQvSHf+x/A33Q+F8XUmIMaG
	 Iv6fTcP2u4Pm7fgNpRQmWCr6erGne5oDtMlg0xEsU7mBNfO5Sk081rE8WTng6sFcXPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0Zf1xR7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F486606A31B;
	Thu,  5 Nov 2026 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0Zf1xR7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3BA1F00A15;
	Thu,  5 Nov 2026 18:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793904135;
	bh=DbVXtjmXEidjKGQfwT1FS56vvbuAVEYXJ6jbibWlecU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=e0Zf1xR7dRMzFDFTHUtoIE+NpuR4mSHskw2E5CphOe7jmB9j6B7W34yLw2x0/zdjd
	 eQ2TVjkcC2AeuPP8BcEoqeukxvx9caP021CXYe0a1NgKFgUoCQMV+ZnrgkzgPmfXnL
	 vcQT8meDFEuxAunwISS1dS7PLfIVbVKxSN7XGPupO8QlSdwU+3vwK/jujaia60Eazf
	 gTFeNsE7kL4ycLnKocIO90gGZyeXSFCduzXrD0DqLlN9l2d5tFmj5fOcnPRPmGpRCM
	 0ifGm0zpx8P3kxmNLaReE8oCGvVWvuWKEmM0dW0wG0Wt1VVgKLkSN1haX0nQPyK2gi
	 iO5Hv2ygzI8ag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 02E7DCE0897; Thu,  5 Nov 2026 10:42:15 -0800 (PST)
Date: Thu, 5 Nov 2026 10:42:14 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Qiliang Yuan <odys.yuan@gmail.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] srcu: Add list_splice_init_srcu()
Message-ID: <493a0897-c117-4517-a3a4-6d84da9d30ae@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com>
 <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com>
 <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop>
 <5b0e7c55-72b1-410a-982c-a62138b9e44c@paulmck-laptop>
 <20261105074554.GA17781@lst.de>
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
In-Reply-To: <20261105074554.GA17781@lst.de>

On Thu, Nov 05, 2026 at 08:45:54AM +0100, Christoph Hellwig wrote:
> On Wed, Nov 04, 2026 at 05:46:45PM -0800, Paul E. McKenney wrote:
> > Given Qiliang's response:
> > 
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Thanks.  I assume you're fine if we carry this in the nvme tree?

Please do!

							Thanx, Paul
