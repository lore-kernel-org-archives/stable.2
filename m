Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFA23955DE;
	Fri, 18 Sep 2026 01:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789695097; cv=none; b=DQE1bLFRur41J2htCFMfmVkkt1Ry+CA73Y348rjJOb6ncC6zMJNo6d3cmW1TAL4zvB8FXe8XOJTUrVBs8zbzHLxaHOb+ovimexzWwKVong8FaaJV5HrnH2P0/hQmWr/kg06JIFOu1BQRThq12852djObkL0Z3xyd8GFYYM2ZLAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789695097; c=relaxed/simple;
	bh=PWy80UZLt+fEKjwmUcpNgnnc7UMsMHoujwCGf6BW4zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhC0TqnlQ8dzsogzfh3TLFttAC+QVbl5Q9GVX1HvgtX0bShOD1zBhkXnu16HGnigI4usgE14kMwZzouybYMrq1jCvCwxUfKq4BsaDJXc786aGKJnD6MQb4w73Mvnn5Vl17gIswuBB/a3nK/yjdiX5P84tIUJfS6q9uZXemov4Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEq40oa1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEq40oa1"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3877F1F00893;
	Fri, 18 Sep 2026 01:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789695094;
	bh=sbKKW3nT9JVsJ3qPTLi+7RzPbQD+A4Vy+uvkP+eNa20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZEq40oa1VRFfulWmXUh05id228g1AneEVMVFE5O308PONjc0mkObeLzKxEdGd41pZ
	 /yZJ5EfIGx98nOtcCdP7WbfUjgB/YmMYQisF0m5vGO5ZVHGvjY6sIf8OcpXArln1cf
	 u23GufsYa9+Ja9/ncDTQWsHp3AmJxKNoOXq7gJUg1vzWWUXTKdqcn+V+zW8RYMXp5k
	 lOx0KWWZRJgckHTB2zkFAW4agefV6ro1ST9qilSNLFPSvaXs0M/zihM9zxo4rVpzUg
	 Juylo1R9/Txp6rv6DmQ4Tts4l9L8lvndt4JwCWZz8V3CQVmglgfdeeHlSsyboXjn72
	 FsH2VSjbyTyBg==
Date: Fri, 18 Sep 2026 04:31:31 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: R Nageswara Sastry <rnsastry@linux.ibm.com>
Cc: Cen Zhang <cenzhang@linux.microsoft.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
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
Message-ID: <aqyUc_7c19MgzAG7@kernel.org>
References: <20260909153433.83117-1-cenzhang@linux.microsoft.com>
 <3e27a805-36e7-4423-b3d1-4e84b4c8f434@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e27a805-36e7-4423-b3d1-4e84b4c8f434@linux.ibm.com>

On Thu, Sep 10, 2026 at 10:14:57AM +0530, R Nageswara Sastry wrote:
> 
> On 09.09.2026 9:04 PM, Cen Zhang wrote:
> > encrypted_key_alloc() stores datablob_len in a u16. It is computed from
> > multiple string and payload lengths. If the result exceeds U16_MAX, the
> > assignment truncates the allocation size. KASAN reports a 32760-byte
> > slab-out-of-bounds write when __ekey_init() copies the master key
> > description into the undersized buffer.
> > 
> > The total payload length stored in key->datalen is also a u16. Use
> > check_add_overflow() to reject values that do not fit either destination,
> > and use kzalloc_flex() for the flexible-array allocation.
> > 
> > Fixes: 7e70cb497850 ("keys: add new key-type encrypted")
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/keyrings/20260826154456.85974-1-blbllhy@gmail.com/
> > Assisted-by: GitHub-Copilot:claude-opus-4.6
> > Signed-off-by: Cen Zhang <cenzhang@linux.microsoft.com>
> > Signed-off-by: Francis Perron <francis@akrites.dev>
> Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
> 
> System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> > ---
> > Changes in v3:
> > - Describe the bounds using u16 and U16_MAX and simplify the commit
> >    message.
> > - Include the KASAN-reported write size.
> > - Remove organization names from the author and sign-off identities.
> > - Remove the unnecessary off-list discussion note.
> > - Use cenzhang@linux.microsoft.com.
> > - No code changes.
> > 
> >   security/keys/encrypted-keys/encrypted.c | 20 ++++++++++++++------
> >   1 file changed, 14 insertions(+), 6 deletions(-)
> > 
> > diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
> > index 59cb77b237b3..e07092ea301a 100644
> > --- a/security/keys/encrypted-keys/encrypted.c
> > +++ b/security/keys/encrypted-keys/encrypted.c
> > @@ -19,6 +19,7 @@
> >   #include <linux/parser.h>
> >   #include <linux/string.h>
> >   #include <linux/err.h>
> > +#include <linux/overflow.h>
> >   #include <keys/user-type.h>
> >   #include <keys/trusted-type.h>
> >   #include <keys/encrypted-type.h>
> > @@ -579,6 +580,7 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
> >   {
> >   	struct encrypted_key_payload *epayload = NULL;
> >   	unsigned short datablob_len;
> > +	unsigned short payload_totallen;
> >   	unsigned short decrypted_datalen;
> >   	unsigned short payload_datalen;
> >   	unsigned int encrypted_datalen;
> > @@ -632,16 +634,22 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
> >   	encrypted_datalen = roundup(decrypted_datalen, blksize);
> > -	datablob_len = format_len + 1 + strlen(master_desc) + 1
> > -	    + strlen(datalen) + 1 + ivsize + 1 + encrypted_datalen;
> > +	if (check_add_overflow(format_len + 1 + strlen(master_desc) + 1
> > +			       + strlen(datalen) + 1 + ivsize + 1,
> > +			       encrypted_datalen, &datablob_len))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if (check_add_overflow(datablob_len,
> > +			       payload_datalen + HASH_SIZE + 1,
> > +			       &payload_totallen))
> > +		return ERR_PTR(-EINVAL);
> > -	ret = key_payload_reserve(key, payload_datalen + datablob_len
> > -				  + HASH_SIZE + 1);
> > +	ret = key_payload_reserve(key, payload_totallen);
> >   	if (ret < 0)
> >   		return ERR_PTR(ret);
> > -	epayload = kzalloc(sizeof(*epayload) + payload_datalen +
> > -			   datablob_len + HASH_SIZE + 1, GFP_KERNEL);
> > +	epayload = kzalloc_flex(*epayload, payload_data, payload_totallen,
> > +				GFP_KERNEL);
> >   	if (!epayload)
> >   		return ERR_PTR(-ENOMEM);
> > 
> > base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
> 
> -- 
> Thanks and Regards
> R.Nageswara Sastry
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
