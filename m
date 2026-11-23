Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.227.64.183
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424120;
	b=pD+RGkE4zpSihSXyWQ/CcqELfmU1g9pYvvftfoG6DjQwXOlLOxEWmALBeXwWlNj6vn3B
	 ZSPFrdoJO1VnvzWs+KJZqApxRMqmdCxqvvhiF18kAtTKqGg0yxkuA8QO8nU2O4Vpl2n2o
	 Jy339owoJ8gOrwefdZ45X9PhX7OPeLHyALeFJjkF3jxnQ3TYJeOJ646gyw4133TJJKtrC
	 k3k6yEEHN5132Nia5FM3mx1uqB0KVIuyiuTjOxYzPK+kvDs8xeTAmooF2Zu3H9G5Ugxx0
	 JR6afMpNIxGcaXeA5n0d09tnfA1JoYjGwraguc1kEJLzQrk90dzPO8rkNDikeIWifiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424120;
	h=DMARC-Filter:DKIM-Signature:X-Virus-Status:X-Virus-Scanned:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=Q7uv1CKc/8sdlZCsInf0Vq7h+/2V0p40nDYXC2y66DU=;
	b=xhErk6Uae4YUdMBPbG4P/I+GkDa0LOGUGDO9TM5BpozB9vUihbPetzSYIvHBQNja7Co8
	 UfSUSe5CwbcFeuKjIsBlC3VLhoFk6V2b6SUkBIRBWIENxfzpo+8Zg8BUV3obU2fBMWVeY
	 BmRCeY4wIJFbFKDVzo5Z9ti42+gXYTv5uOaV1easP9uhfK+Re6oYwaDJ7fxXPhDX6teV6
	 RbdBjQn2w92KmGuEHox8nviAV4snzBfMkUohP/vK/LGLZ/OTj/3G4u6hKdGOTOSNFBfyH
	 GMgvh9KqdKfbIkIeC7hG0t+w2K6XuAueh6KvdXSbs9TrI70RM12b+MGbgtrg5vWsVLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rere.qmqm.pl;
	spf=pass smtp.mailfrom=rere.qmqm.pl;
	dkim=pass header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.a=rsa-sha256 header.s=1 header.b=peOC68H3;
	arc=none smtp.remote-ip=91.227.64.183
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683D6606A31A;
	Mon, 23 Nov 2026 08:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 683D6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.a=rsa-sha256 header.s=1 header.b=peOC68H3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1795424110; bh=Gh8XrR/kQDGr9B/T4iYtI0fqTNghQLQy/youiwIJ9S0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=peOC68H3AzJeeW8cN8dk/AmhuUSFFEfGoEFDlEw4A735DfxrENq01HjaTuzQO/d1y
	 MW4lk2VNNRJQJ9Rh7xbChj7o6lC9M9NtaLNm0/JlvBU3c59vYhnDnQftYQ/n5tRRQ/
	 PvWip+vIuB0Ih5r79JQPBgWKpoy37ccFWVaMkQRGevLH+QYXpbWZsrlb5ey2AQjY+Y
	 g/fKlfzmf2L2Z/N0mUU+n0tyEjg2LbTCabvWFhvuyzc3VMQI9QUc+Wfzt6r1TpL6Mo
	 c9mZXdaRX8uCHyduSW1l4xaLHzHsfNMzuzcVjhsNScGIfEYkc6BwZY23wqxQQglp31
	 wHMiWncBMsISQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.4.6 at mail
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4jY0Bj24FDz5J;
	Mon, 23 Nov 2026 09:55:09 +0100 (CET)
Date: Mon, 23 Nov 2026 09:55:07 +0100
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: fabricioakio@gmail.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neill Kapron <nkapron@google.com>,
	Krystian Kaniewski <krystianmkaniewski@gmail.com>,
	Brian Ellis <brianellis@gotenna.com>, Ai Chao <aichao@kylinos.cn>,
	Prashanth K <prashanth.k@oss.qualcomm.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] usb: gadget: u_serial: Publish the console only
 under port_lock
Message-ID: <awP_a5IqlYHPvx-G@qmqm.qmqm.pl>
References: <20261122-u-serial-console-dequeue-v2-0-820f355827e6@gmail.com>
 <20261122-u-serial-console-dequeue-v2-1-820f355827e6@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261122-u-serial-console-dequeue-v2-1-820f355827e6@gmail.com>

On Sun, Nov 22, 2026 at 10:48:34PM -0300, Fabricio Akio via B4 Relay wrote:
> From: Fabricio Akio <fabricioakio@gmail.com>
> 
> gserial_connect() and gserial_disconnect() find the console through
> port->console under port_lock, but gs_console_init() sets it before
> taking the lock, and gs_console_exit() clears it after dropping it.
> A host connect while the console is being turned on through configfs
> can then connect it twice, leaking the first request. While it is
> being turned off, a connect can attach a request to the console being
> freed and schedule its work after cancel_work_sync().
> 
> Set and clear port->console under port_lock, together with connecting
> and disconnecting the console.
> 
> Fixes: d7cb8fb7aa7d ("usb: gadget: u_serial: allow more console gadget ports")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
> ---
>  drivers/usb/gadget/function/u_serial.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
> index 0a304f508bc3..1f0110ea7f6a 100644
> --- a/drivers/usb/gadget/function/u_serial.c
> +++ b/drivers/usb/gadget/function/u_serial.c
> @@ -1173,10 +1173,10 @@ static int gs_console_init(struct gs_port *port)
>  		return err;
>  	}
>  
> -	port->console = cons;
>  	register_console(&cons->console);

Note that there is `if (port->console) return` just at the start of this
function. If there is indeed a race here, that should be taken into
account.

-- 
Micha³ Miros³aw
