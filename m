Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D1C4BB297;
	Wed,  9 Sep 2026 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788994886; cv=none; b=l4HjRqZ+FdXWfkiqw8RzgYv4yQBDhSVQ/DmgFBaOvXUYfKUyr0bJSxytA578w8lLTMbU1s5uF87aR+WL/CEtFKcib9BZ1RKZlgYNyUrSOP0RlGRV/U5qiAkxwBbKQzoYyrN5uLlFYPsFTdTelabN56xO70o1s3P7ZQL/PuMmPM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788994886; c=relaxed/simple;
	bh=NNXlyDfgd+hIRlMNmvN+k6m7uLUHdTmSB/BQHjNeW7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2xYd3l3IzRPm3Fm6n0zNjVLv9dl+GWUAxEdg9OTnTkm/WILHYUSjJqGzkMNVby8XQc45DkhwfOmNH64UngnykwDXy4TJAcDMy0VZ3ZtbGnjV+5SMzkdoNwgMBTU4rJJW57r1n9x29lAwFLvLvp6Nz4S6+NvY2HD6+xqPop7oIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmvFgcyS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmvFgcyS"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 335321F000FF;
	Wed,  9 Sep 2026 23:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788994880;
	bh=VnS6NhGS4JjXymS76BB+sb8wkEANRKWXGcm8KezpYV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nmvFgcySp2ho/XtXyAPUZUMubkCeFdhp6/roSbTkQqk282e27Ujw9qz6KEt3SUYhB
	 sLyQP/r7+DpYjCofo66NKGpHHhZD/GlJ48qfeo2ZAXUNh+ch6/KbGXnKNiQS5uwo4q
	 VbIEcxebky2OylDc6zzjM+g5OjMunpL8phcyA9hFNZF202fywTTfmm81T/ld3HHUJ6
	 C0fJ4VtbVhhMwIIYH3D7JVALIZMeaDl6qUFVUeQ2ZG7GQS/PCpyiJ1j4fDOulOXe6a
	 X+D39Lr+YyP9q4UFYKNvBEofrYiPg5xAjGa7WMnWCqm0JhnkMFU0WI9jsIUyHTutxb
	 qU6f3xC/aWLQQ==
Date: Thu, 10 Sep 2026 02:01:17 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cen Zhang <cenzhang@linux.microsoft.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Roberto Sassu <roberto.sassu@polito.it>,
	David Safford <safford@watson.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>, Francis Perron <francis@akrites.dev>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Akrites SIRT <sirt@akrites.dev>,
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
	kys@microsoft.com
Subject: Re: [PATCH v3] KEYS: encrypted: fix integer overflow of datablob_len
Message-ID: <aqHlPTAVoiGeE_Hb@kernel.org>
References: <20260909153433.83117-1-cenzhang@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909153433.83117-1-cenzhang@linux.microsoft.com>

On Wed, Sep 09, 2026 at 11:34:33AM -0400, Cen Zhang wrote:
> encrypted_key_alloc() stores datablob_len in a u16. It is computed from
> multiple string and payload lengths. If the result exceeds U16_MAX, the
> assignment truncates the allocation size. KASAN reports a 32760-byte
> slab-out-of-bounds write when __ekey_init() copies the master key
> description into the undersized buffer.
> 
> The total payload length stored in key->datalen is also a u16. Use
> check_add_overflow() to reject values that do not fit either destination,
> and use kzalloc_flex() for the flexible-array allocation.
> 
> Fixes: 7e70cb497850 ("keys: add new key-type encrypted")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/keyrings/20260826154456.85974-1-blbllhy@gmail.com/
> Assisted-by: GitHub-Copilot:claude-opus-4.6
> Signed-off-by: Cen Zhang <cenzhang@linux.microsoft.com>
> Signed-off-by: Francis Perron <francis@akrites.dev>
> ---
> Changes in v3:
> - Describe the bounds using u16 and U16_MAX and simplify the commit
>   message.
> - Include the KASAN-reported write size.
> - Remove organization names from the author and sign-off identities.
> - Remove the unnecessary off-list discussion note.
> - Use cenzhang@linux.microsoft.com.
> - No code changes.
> 
>  security/keys/encrypted-keys/encrypted.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
> index 59cb77b237b3..e07092ea301a 100644
> --- a/security/keys/encrypted-keys/encrypted.c
> +++ b/security/keys/encrypted-keys/encrypted.c
> @@ -19,6 +19,7 @@
>  #include <linux/parser.h>
>  #include <linux/string.h>
>  #include <linux/err.h>
> +#include <linux/overflow.h>
>  #include <keys/user-type.h>
>  #include <keys/trusted-type.h>
>  #include <keys/encrypted-type.h>
> @@ -579,6 +580,7 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>  {
>  	struct encrypted_key_payload *epayload = NULL;
>  	unsigned short datablob_len;
> +	unsigned short payload_totallen;
>  	unsigned short decrypted_datalen;
>  	unsigned short payload_datalen;
>  	unsigned int encrypted_datalen;
> @@ -632,16 +634,22 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>  
>  	encrypted_datalen = roundup(decrypted_datalen, blksize);
>  
> -	datablob_len = format_len + 1 + strlen(master_desc) + 1
> -	    + strlen(datalen) + 1 + ivsize + 1 + encrypted_datalen;
> +	if (check_add_overflow(format_len + 1 + strlen(master_desc) + 1
> +			       + strlen(datalen) + 1 + ivsize + 1,
> +			       encrypted_datalen, &datablob_len))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (check_add_overflow(datablob_len,
> +			       payload_datalen + HASH_SIZE + 1,
> +			       &payload_totallen))
> +		return ERR_PTR(-EINVAL);
>  
> -	ret = key_payload_reserve(key, payload_datalen + datablob_len
> -				  + HASH_SIZE + 1);
> +	ret = key_payload_reserve(key, payload_totallen);
>  	if (ret < 0)
>  		return ERR_PTR(ret);
>  
> -	epayload = kzalloc(sizeof(*epayload) + payload_datalen +
> -			   datablob_len + HASH_SIZE + 1, GFP_KERNEL);
> +	epayload = kzalloc_flex(*epayload, payload_data, payload_totallen,
> +				GFP_KERNEL);
>  	if (!epayload)
>  		return ERR_PTR(-ENOMEM);
>  
> 
> base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
> -- 
> 2.55.0

Thanks!

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
