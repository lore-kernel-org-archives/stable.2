Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795469147;
	b=B5zZfH1AYVQuj3Vv2pI8HW3NIe5pi4WXE8ufvtflKA9T6UqVt4VHWba26Ln1/Vqf6n3s
	 oR3IgQB1O9yU1HhbFzx1HaNMobnkKu+TpxkXYq4GrY8ao28WeWKhaYfjlUosnMqaZdII9
	 Yqp/0FGPq7CMbceNq+T4m0a/5ZHs/mY+FwrAP519LLzbTpAQHPxGN6UavLItR1WQJ7fje
	 AOG0ZSWPffZvWSSSh1D+HBiAevotzfv5bdLW3zq7LxP+irOeZ/nZOd29HAowbYV6jSPWQ
	 A85PBLjIg8KTkR9sxtllMs0w70D/HUWfgPqAfGeM8ev8CR2now5/4GANz9vDEdVgJSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795469147;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ztADtyHmHGAk4JObPomuXMSa3LOmAYf1N2zGLOoiWU4=;
	b=gvcemBK/wE1AxrD5r1gRiTm1Ox+T/asrYO5Uz/ItFHo9jzjBb/qWPeRVD14nYbvpu7Z6
	 Btvv9T/RY7U+Qd122bWJUtxwdmez2mPWEwog4Kd13ePq4hkKhc38Q8wGzt4YpKzkjMbh1
	 Oi8EGAa7SD1wviwAK+oHIwIkUbiCME3cmdl5JS1lRkU4Vk8GnZcRm7PUae1qKfu8lReUV
	 c5/pdzvFRTL1A3CClNfwfBNtyvds9b78nK1f9cMABTkyol8KvVzSFgEsVHlaTiU71XYJI
	 cxpgDb449dNhm+ki7+49qjrCoFV23V77d2DWuGWfrF/EXGFvWhXzP7fs81M0flpcGQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DvBMv4jS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C412C606A33C;
	Mon, 23 Nov 2026 21:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DvBMv4jS
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B26DB1F000C6;
	Mon, 23 Nov 2026 21:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795469147;
	bh=ztADtyHmHGAk4JObPomuXMSa3LOmAYf1N2zGLOoiWU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DvBMv4jSryqIBus7z1VTiXoXdUWwaLmsH06VMxWuXV8IyAdwkBQCIFh6sz6d/ujAZ
	 Se9D6FYMFr/GZd3mimd2P89AAQ/NWDiKFxTdB8/W63qnvMFFztjWlmFGuDQrhIhaSk
	 YabdPwRnoxBIL0WFd0CMRiFCYe4JPbrHzhFAvgFP3PyAl9KGKMOXmk/VlOCeVoVwsR
	 r4mQVjGQWKHLYjFeLVEhUCo0L3cmAvQi4hBdQxLAdqlANleKNcfZtqUFIi5tn6ad7y
	 gWlGTNWU0chp6rBtXsExxx4sOn5QFI7fTAGwOA9ZHpP3ceASCLkeEqOnxqfSaz5JOz
	 i6kfwx0jgwasg==
Date: Mon, 23 Nov 2026 23:25:43 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Guicai Ma <maguicai@kylinos.cn>, James Morris <jmorris@namei.org>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E. Hallyn" <serge@hallyn.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] KEYS: Fix userspace buffer overflow in
 keyctl_pkey_e_d_s()
Message-ID: <awSvVxRb9dRd-AWX@kernel.org>
References: <20261123211959.4102708-1-jarkko@kernel.org>
 <20261123211959.4102708-2-jarkko@kernel.org>
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
In-Reply-To: <20261123211959.4102708-2-jarkko@kernel.org>

On Mon, Nov 23, 2026 at 11:19:58PM +0200, Jarkko Sakkinen wrote:
> From: Guicai Ma <maguicai@kylinos.cn>
> 
> Commit cb481e59ea6c ("KEYS: fix overflow in keyctl_pkey_params_get_2()")
> changed keyctl_pkey_params_get_2() to set params->out_len to the maximum
> output size of the operation instead of uparams.out_len, so that the
> kernel buffer allocated in keyctl_pkey_e_d_s() is large enough.
> 
> Because uparams.out_len is no longer kept, keyctl_pkey_e_d_s() copies
> ret bytes to _out without checking whether the result fits in the
> caller's buffer. If a smaller out_len was passed, copy_to_user() writes
> past the end of _out instead of failing with -EOVERFLOW.
> 
> uparams.out_len cannot simply be required to be at least the maximum
> output size in keyctl_pkey_params_get_2(), since KEYCTL_PKEY_DECRYPT
> with enc=pkcs1 can return a plaintext shorter than max_dec_size into a
> matching smaller buffer.
> 
> Pass uparams.out_len back to keyctl_pkey_e_d_s() and return -EOVERFLOW
> before copy_to_user() if ret exceeds it.
> 
> Cc: stable@vger.kernel.org # v7.2+
> Fixes: cb481e59ea6c ("KEYS: fix overflow in keyctl_pkey_params_get_2()")
> Signed-off-by: Guicai Ma <maguicai@kylinos.cn>
> ---
>  security/keys/keyctl_pkey.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
> index e7121523b9c9..b5f82804b5ad 100644
> --- a/security/keys/keyctl_pkey.c
> +++ b/security/keys/keyctl_pkey.c
> @@ -113,7 +113,8 @@ static int keyctl_pkey_params_get(key_serial_t id,
>  static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_params,
>  				    const char __user *_info,
>  				    int op,
> -				    struct kernel_pkey_params *params)
> +				    struct kernel_pkey_params *params,
> +				    u32 *user_out_len)
>  {
>  	struct keyctl_pkey_params uparams;
>  	struct kernel_pkey_query info;
> @@ -183,6 +184,8 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
>  	}
>  
>  	params->in_len  = uparams.in_len;
> +	if (user_out_len)
> +		*user_out_len = uparams.out_len;
>  
>  	switch (op) {
>  	case KEYCTL_PKEY_VERIFY:
> @@ -264,10 +267,12 @@ long keyctl_pkey_e_d_s(int op,
>  		       void __user *_out)
>  {
>  	struct kernel_pkey_params params;
> +	u32 user_out_len;
>  	void *in, *out;
>  	long ret;
>  
> -	ret = keyctl_pkey_params_get_2(_params, _info, op, &params);
> +	ret = keyctl_pkey_params_get_2(_params, _info, op, &params,
> +				       &user_out_len);
>  	if (ret < 0)
>  		goto error_params;
>  
> @@ -310,6 +315,10 @@ long keyctl_pkey_e_d_s(int op,
>  	if (ret < 0)
>  		goto error_out;
>  
> +	if (ret > user_out_len) {
> +		ret = -EOVERFLOW;
> +		goto error_out;
> +	}
>  	if (copy_to_user(_out, out, ret) != 0)
>  		ret = -EFAULT;
>  
> @@ -349,7 +358,7 @@ long keyctl_pkey_verify(const struct keyctl_pkey_params __user *_params,
>  	long ret;
>  
>  	ret = keyctl_pkey_params_get_2(_params, _info, KEYCTL_PKEY_VERIFY,
> -				       &params);
> +				       &params, NULL);
>  	if (ret < 0)
>  		goto out_free_params;
>  
> -- 
> 2.47.3
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
