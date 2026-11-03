Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710853;
	b=jDk6rqLVcy4LWUdhJ/Hn2xVFedbhhBhShNmKhy+MNncMXUym9fqCaOnt5Ur4KQ26yUFK
	 OUrZk62ifRZL0gxdx1RybfY1TNfEoqulPnYh1UweJabLRvzVmDsU25z/KZEo7mtyth4CI
	 4Dlekr7BR/CwOR6C4r92/UAlyNgG96hkBl93tqqnaE3mK3m/Mlq2cLQqIPsf14qKGZQQV
	 wvEQTQVinYn+y70S9bULpd/JntW1y/23tOGPIF1yLttyQMKeRuwE4H9fCRoQlpjRUOfib
	 UUjf36peNQGVSF/vHBJrEQgUonuc1Jlih+z6gBJbcOxGyHk3QYh9MwTCTmHm3sYg1pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710853;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KDvkIJpsL2iF0Ol0UE1M+BI5UFldgpU1Os03NfWfA8k=;
	b=YfDgnADJvklockIuNPl0fSKqlmYFAwRORsa/7/5A6Ws+ylr7MeFrOCHJXa//Vnw2zJiL
	 OYEPPAwfdjg7MfQN9drXF7ZFiDOfGsMfUTypmMamrXm+Ufn/Bc++CGWm9FwkleQx9wDYp
	 s+ANlIpJ4AR/SLIFkUAoErAGTcAl/jbOoE8vqUN5AVRuwkqfg5W86ctNsIonf2OB8u8yf
	 gr8ZvVPG+XzgiDJZ5WRRyLSJO+5TJCrV37U0ILKqIzJkkXQqeHQiWbcKm7g8LWUB43Od+
	 2n7zBv1gCrAaXWGaGGrgHLIsGRrTT977ptsmfLXrsaKwj+j4BimvpQvexE/m+kQkRFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HAoHtOC+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id DFA25606A327;
	Tue,  3 Nov 2026 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HAoHtOC+
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E28651F00919;
	Tue,  3 Nov 2026 13:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793710852;
	bh=KDvkIJpsL2iF0Ol0UE1M+BI5UFldgpU1Os03NfWfA8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HAoHtOC+bPyONNuGQAiCOetoZe2w+0vf5XU470B2EcE0vQ/mn2sFb5hUbWofwbMmn
	 zwcfGP8PFj+GoufDx6Vqop7XuyKj9fi5i2EAhlcmVEvhhbz8AYIs/phP284rfpTlww
	 aCRH9mJfqRV0N4pfgSt6tsUsSDZVl6Yu4Mf4fEoiyUFtwbvY5ywyE9Ch7WUlsmsFMX
	 tRZoAdBOYCN5oXPRpzPtN/TOSzGt/6sqeS/51EKu35H1oNYlguoDdOT9DemdP15W6n
	 zSFMOzIhsEZMfoYFLSSyJz1BwLgIte3XPaYTa+9+9xlbzPlFqV//4Tz34jnTvCvGfD
	 YHGvg1dmgsJLA==
Date: Tue, 3 Nov 2026 15:00:48 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] tpm: eventlog: check the payload size before reading tag
 events
Message-ID: <aunbAIcxu8XTW0Ph@kernel.org>
References: <20261103084155.426783-1-zhugl3@xiaopeng.com>
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
In-Reply-To: <20261103084155.426783-1-zhugl3@xiaopeng.com>

On Tue, Nov 03, 2026 at 04:41:55PM +0800, Guanglei Zhu wrote:
> The EVENT_TAG branch of get_event_name() casts the event payload to
> struct tcpa_pc_event and reads from it:
> 
> 	pc_event = (struct tcpa_pc_event *)event_entry;
> 
> 	switch (do_endian_conversion(pc_event->event_id)) {
> 	...
> 		for (i = 0; i < 20; i++)
> 			d_len += sprintf(&data[2*i], "%02x",
> 					pc_event->event_data[i]);
> 
> The log iterators only verify that the event header plus the declared
> event_size stays within the log buffer; they do not require the
> payload of an EVENT_TAG entry to be large enough for the fields the
> branch reads. A truncated entry makes the branch read up to 20 bytes
> of event_data[] past the end of the entry, and, for the last entry in
> the log, past the end of the buffer itself.


What does the spec say about this?

> 
> Skip entries whose payload cannot even hold the event id, and skip
> the 20-byte digest dump when the payload cannot hold the full
> tcpa_pc_event header plus the digest, so the branch never reads
> beyond the entry it is formatting.
> 
> Fixes: 55a82ab3181b ("[PATCH] tpm: add bios measurement log")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> ---
>  drivers/char/tpm/eventlog/tpm1.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
> index 0397e3361020..f93a358a706e 100644
> --- a/drivers/char/tpm/eventlog/tpm1.c
> +++ b/drivers/char/tpm/eventlog/tpm1.c
> @@ -178,6 +178,10 @@ static int get_event_name(char *dest, struct tcpa_event *event,
>  		}
>  		break;
>  	case EVENT_TAG:
> +		if (do_endian_conversion(event->event_size) <
> +		    sizeof(pc_event->event_id))
> +			break;
> +
>  		pc_event = (struct tcpa_pc_event *)event_entry;
>  
>  		/* ToDo Row data -> Base64 */
> @@ -203,6 +207,9 @@ static int get_event_name(char *dest, struct tcpa_event *event,
>  			name = tcpa_pc_event_id_strings[do_endian_conversion
>  							(pc_event->event_id)];
>  			n_len = strlen(name);
> +			if (do_endian_conversion(event->event_size) <
> +			    sizeof(struct tcpa_pc_event) + 20)
> +				break;
>  			for (i = 0; i < 20; i++)
>  				d_len += sprintf(&data[2*i], "%02x",
>  						pc_event->event_data[i]);
> -- 
> 2.50.1
> 

Br, Jarkko
