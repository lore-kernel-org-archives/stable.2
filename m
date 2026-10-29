Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269348;
	b=IU9kQhrXLxAnDJX9ZEN3sGGmfXxFh/b7D6k/OKzJgDxwu99xQab+6cxFeP6IIGZXSVUD
	 HNK4DgnD5LXdsVYMwl5gyM/kBylRVHTNT5up4HOOwe5JgNP6xfKh6Um7o/2FFJ5zYjV5W
	 2Jb4SFUS3gPvjKn6WZPTafh1PdHQtzL0sZGMrZRsM0WL/ithg6mfoM6U69TA5I1GhVUze
	 MOB32/9n/qMtuCr1ddGmwhfDnAWNRzhYp70F3kI37A+Uo/A5ltR4Dmg63kglji8IZRh9Z
	 7iaUSrGniMsagxGyNp3noJesF0+hi+LcNYEzkkG/xTV41kkB63oZPcma4ywBM2uPs9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269348;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WEwZYcuaAT+y33Zr9c1xlmb2GPWDUVDkk4ZHB+IYvgk=;
	b=lDqLGN5m++Ee2HCXBds95aCllht10FTwNU13mBMF4P+UoYcHNSZ9dDchok4uziAQsAmR
	 j/drK/XudJWqltPNeKuQ3ouqFhKJE0A9zyvdqrM5OMxl1UoFOU6vLrp71HFLgbMOvMPtj
	 Xzl3m4+IS/nAWaOS8INwPZT+gouLugvv2FOpdwIyzg8wnpMrx8P+sAjoo2/qINK3veMyW
	 E6gFrlshZ5WINZkKwly1Y8mvc24FjTK3FNvAGSOGjTV0njwxwQ21pSOWNXrpUvFKjhJ5i
	 f0cT1Pbe2k3L1Bje1IyfXZ1OeEFnHD2CEkI3mF5uRGfyH31iuhv2bJfq4nA4bJ71VXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MPF6fhoF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB94D606A31C;
	Thu, 29 Oct 2026 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MPF6fhoF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847EA1F031E2;
	Thu, 29 Oct 2026 10:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793269347;
	bh=WEwZYcuaAT+y33Zr9c1xlmb2GPWDUVDkk4ZHB+IYvgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MPF6fhoFkWfuyQjAe7WGw6laZy2mxakETrlJlKqo4IRk35lXolhaqzyyy9EJwGvAn
	 pLxk8G19UjPsn0azqFHr/Bqg1Ty9kcG8WAVKDzUcjVYgsUrBZbbCfJ8w0icEkzeWPA
	 BR9ilbaSCQYnxnn04Zx7j65i6GUQQ453gmNBQAuL/cupDMmlRXwmD2zDgH+ZY41MVb
	 qjd1hNMhQfkn0VDXqZZ6EeK2joF27g+p9VEaEuBCVZ6NirEbPf5goabuJXyuKqNG3Y
	 X5SGXqZkX1++SwtKjvR9Qg6PwBBmRH2bucMB35ZXPQ9SNz5EoWQaJWED1bWcb/AS70
	 mOoN4e3/7VmKg==
Date: Thu, 29 Oct 2026 10:22:21 +0000
From: Simon Horman <horms@kernel.org>
To: Yuqi Xu <xuyuqiabc@gmail.com>
Cc: netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev,
	David Heidelberg <david@ixit.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org, Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com,
	Mark Greer <mgreer@animalcreek.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Ian Ray <ian.ray@gehealthcare.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Thierry Escande <thierry.escande@linux.intel.com>,
	Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH net 1/1] nfc: digital: fix use-after-free in unregister
Message-ID: <20261029102221.GF257209@horms.kernel.org>
References: <cover.1791172164.git.xuyuqiabc@gmail.com>
 <1792999448.107874-2-xuyuqiabc@gmail.com>
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
In-Reply-To: <1792999448.107874-2-xuyuqiabc@gmail.com>

On Mon, Oct 26, 2026 at 03:24:07PM +0800, Yuqi Xu wrote:
> nfc_digital_unregister_device() cancels its own workqueue items and
> then frees every queued digital_cmd. A command already submitted to
> the driver remains the argument of the async completion.
> digital_send_cmd_complete() can still assign cmd->resp after that
> object has been freed, which is a use-after-free.
> 
> Abort the in-flight driver command before reclaiming the queue, and
> drain the completion work the driver may schedule from abort. Once
> the nfc device is shutting down, do not queue or submit another
> command: finishing the aborted one would otherwise hand the next
> queued command to the driver while it is being freed.
> 
> Port100 and nfcsim invoke the digital completion from a private work
> item, so flush that work before abort returns. trf7970a completes from
> a delayed timeout work and from its IRQ thread; handle its MD listening
> state in abort and shutdown, and stop the timer before the device is
> released. st95hf's IRQ thread can observe that remove already ran and
> must not call back into the freed command.
> 
> Fixes: 59ee2361c924 ("NFC Digital: Implement driver commands mechanism")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
> Reviewed-by: Ren Wei <weir@nebusec.ai>

Reviewed-by: Simon Horman <horms@kernel.org>

