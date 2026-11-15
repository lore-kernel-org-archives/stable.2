Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794769708;
	b=P+iArBeRS/jN9AyYg6b+7Bn+lzUHb70pT4hVEcOES7IzyrvGWDqkq4YtVAvm/+/vhC1J
	 zg0r1del1DB/qGuYtTxXVmhoNgQjNog51GR4st7xX6vTszZa+pFtgK0cPOxQvUVCEBVv1
	 YbCxPzkzWfgcNE1fI0qytF9subhsyR+Yav4s3a9CEliW2rHVU3piAtBEOx5+nrK6EMqaS
	 QnnZyfvyRcD01wLNuvvtMNPJzGCSXKvg027WiQju7zti1JDFLAfUnMmeM4Qs5jRc12Tt3
	 irO1jYzvCucEt2CUTeXpR849pNYori08PCVTIcA8qE/nbFILbgzjk1oaKXvJ9lnl7Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794769708;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=10OkA8VAmfu8rQr5arZGbBrpbY2LKxX+xjHUgRXefG8=;
	b=duhJ7FZGtVi4Ub6lxGdLuPTi06IPF9FeIh1aCdUYzFUWwKoVc1RWnq/gz/OD+8rhT4em
	 ayrqzrNA2ckixxSu/ZtGjKW+ridBXsE/q9dAKbRRzKfBNpJ/SDs9UrDP4my0+We/i/53K
	 axnFx+x6Sxv+vc0/BPYDTbElrwRoC+qZrHKQ62q/f0/dLUL6iVQE6JsJPxeGeuS36XIzT
	 tyZVi31nCk5vb9phg0523Ea2iaQCzS/tCWsAbqEBmSigVGySRxRwHXJcKqcReRErccaDK
	 fBe1A35dG5XTakPaxVagGoUPFQPScK4QRyOQIuPtN0PXRuYNgeatuQPxuPEUU+oFUUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gDfY/kDz";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1A8606A31F;
	Sun, 15 Nov 2026 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDfY/kDz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5DC1F000C4;
	Sun, 15 Nov 2026 19:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794769707;
	bh=10OkA8VAmfu8rQr5arZGbBrpbY2LKxX+xjHUgRXefG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gDfY/kDz8J1wjtKyqTDjv9TfS2eVmZtqF3Z2rbb/xXlXsLU/9oxeoazJPVL4EfvWj
	 HjxYB96daq06o+GzBz5C8IU3fgFqW0O84wYrvTwTk3huTddlZ0I9jyOV9a28gX+bFi
	 Msd7uIGn40CccVinAR/dBlS0ZMzvSLm8crxxskPZEY+jQCSmqRedpDLspbGrH+tFRs
	 CHPx/BDnyfHYreHeLU/AllWaOdykBg0otPp1Jquxf+T1e8SuQiU89RZrHYQTXGJNqI
	 C72G3irnR/CU+JSocdLjLHtoM0bvNe2Fia2T9dhiTVdos65YV/WOTb8ppbFila4hvp
	 FNHbTnrbea2zA==
Date: Sun, 15 Nov 2026 11:08:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH net] net/sched: cls_flow: pin file with get_file_rcu
 before reading f_cred
Message-ID: <20261115110826.502858e7@kernel.org>
In-Reply-To: <20261111153106.580776-1-tristmd@gmail.com>
References: <20261111153106.580776-1-tristmd@gmail.com>
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

On Wed, 11 Nov 2026 15:31:06 +0000 Tristan Madani wrote:
> flow_get_skuid() and flow_get_skgid() read sk->sk_socket->file->f_cred
> without holding a reference to the file. Since the file slab uses
> SLAB_TYPESAFE_BY_RCU, a concurrent close() may free and recycle the file
> object, causing stale credential data to be read through f_cred.

Missing annotations. Please also make sure you include the answer to
the questions from the bug discovery bot in the commit message of v2.
Otherwise it will ask you again.

net/sched/cls_flow.c:217:32: warning: incorrect type in argument 1 (different address spaces)
net/sched/cls_flow.c:217:32:    expected struct file [noderef] __rcu **f
net/sched/cls_flow.c:217:32:    got struct file **
net/sched/cls_flow.c:235:32: warning: incorrect type in argument 1 (different address spaces)
net/sched/cls_flow.c:235:32:    expected struct file [noderef] __rcu **f
net/sched/cls_flow.c:235:32:    got struct file **
-- 
pw-bot: cr
